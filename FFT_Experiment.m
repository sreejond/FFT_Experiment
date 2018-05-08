prompt = 'Plot your sin wave from 0 to ?: ';
range = input(prompt);

sample_size = 2048;
x = linspace(0, range, sample_size);
y = 0;
freq_array = [];

cnt = 0;
while true
    cnt = cnt + 1;
    prompt = 'Add sin wave?(y/n): ';
    str = input(prompt, 's');
    if str == 'y' || str == 'Y'
        prompt = 'Amplitude?: ';
        amp = input(prompt);
        
        prompt = 'Frequency?: ';
        freq = input(prompt);
        freq_array = [freq_array freq];
        
        prompt = 'Phase?: ';
        phase = input(prompt);
        
        f = @(x) amp * sin(freq*x + phase);
        y = y + f(x);
        
        figure(cnt);
        plot(x, y);
    else
        break;
    end
end

prompt = 'DFT sample size?: ';
n = input(prompt);

width = sample_size/n;
width_plot = range/n;
sample_points_x = zeros(n,1);
sample_points_y = zeros(n,1);
sample_points_x(1) = 0;
sample_points_y(1) = y(1);
for i = 1:n-1
    index = i*width;
    index_plot = i * width_plot;
    sample_points_x(i+1) = index_plot;
    sample_points_y(i+1) = y(index);
end

figure(cnt);
plot(x, y);
hold on;
scatter(sample_points_x, sample_points_y, 'x');
hold off;

fft_list = fft(sample_points_y);
amplitude_list = 2*abs(fft_list)/n
phase_list = angle(fft_list) + pi/2

figure_cnt = cnt;
for i = 1 : cnt-1
    index = freq_array(i) + 1;
    amp = amplitude_list(index);
    freq = freq_array(i);
    phase = phase_list(index);
    
    f = @(x) amp * sin(freq*x + phase);
    y = f(x);
    
    figure_cnt = figure_cnt + 1;
    figure(figure_cnt);
    plot(x, y);
end

figure(figure_cnt + 1);
frequency_list = linspace(0, n-1, n);
stem(frequency_list, amplitude_list, 'filled');
title('Amplitude Spectrum');
xlabel('Frequency');
ylabel('Amplitude');