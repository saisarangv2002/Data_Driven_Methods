% Define the sampling rate
close all; clear all; clc;
FS = 11025;

% Load the audio files
dry_audio = audioread('sound1.wav');
% Load other audio files if needed

% Load the impulse-response filters
filter_xyz = audioread('FilterEcho.wav');
%filter= (filter_xyz(:,1)+filter_xyz(:,2))/2;
plot(filter_xyz)
%%
% Convolve audio with filters
filtered_audio_xyz = conv(dry_audio, filter_xyz);

% Trim the filtered audio to match the original length
filtered_audio_xyz = filtered_audio_xyz(1:length(dry_audio));

% Define mixing ratios
dry_ratio = 0.9;
wet_ratio = 0.1;

% Mix dry and wet audio
mixed_audio_xyz = dry_ratio * dry_audio + wet_ratio * filtered_audio_xyz;
%%
% Play the original audio
sound(dry_audio, FS);
%%
% Play the filtered audio
sound(filtered_audio_xyz, FS);
%%
% Play the mixed audio
sound(mixed_audio_xyz, FS);

