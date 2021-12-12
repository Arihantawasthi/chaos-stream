--To execute this file, enter postgres shell and enter the command below
-- \i /home/path/to/file/file.sql

CREATE TABLE users (
    user_id BIGSERIAL NOT NULL PRIMARY KEY,
    username VARCHAR(100) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    pass VARCHAR(100) NOT NULL,
    verified BOOLEAN NOT NULL,
    pic_url VARCHAR(200)
);

CREATE TABLE channels (
    channel_id BIGSERIAL NOT NULL PRIMARY KEY,
    channel_name VARCHAR(100),
    created_on TIMESTAMP NOT NULL,
    img_url VARCHAR(500),
    bg_url VARCHAR(500),
    email VARCHAR(100) UNIQUE NOT NULL,
    pass VARCHAR(100) NOT NULL,
    subs_count BIGINT DEFAULT 0
);

CREATE TABLE videos (
    video_id BIGSERIAL NOT NULL PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    thumbnail VARCHAR(500) NOT NULL,
    video_desc VARCHAR(500) NOT NULL,
    channel_id BIGINT NOT NULL,
    FOREIGN KEY (channel_id) REFERENCES channels (channel_id),
    duration BIGINT NOT NULL,
    created_on TIMESTAMP NOT NULL,
    video_url_144p VARCHAR(500),
    video_url_240p VARCHAR(500),
    video_url_360p VARCHAR(500),
    video_url_480p VARCHAR(500),
    video_url_720p VARCHAR(500),
    video_url_1080p VARCHAR(500)
);

CREATE TABLE notifications (
    notification_id BIGSERIAL NOT NULL PRIMARY KEY,
    user_id BIGINT NOT NULL,
    channel_id BIGINT NOT NULL,
    noti_img_url VARCHAR(200) NOT NULL,
    note VARCHAR(100) NOT NULL,
    notification_date TIMESTAMP NOT NULL,
    seen BOOLEAN NOT NULL DEFAULT true,
    FOREIGN KEY (channel_id) REFERENCES channels (channel_id),
    FOREIGN KEY (user_id) REFERENCES users (user_id)
);

CREATE TABLE subscriptions (
    subscription_id BIGSERIAL NOT NULL PRIMARY KEY,
    user_id BIGINT NOT NULL,
    channel_id BIGINT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users (user_id),
    FOREIGN KEY (channel_id) REFERENCES channels (channel_id)
);

CREATE TABLE comments (
    comment_id BIGSERIAL NOT NULL PRIMARY KEY,
    user_id BIGINT NOT NULL,
    video_id BIGINT NOT NULL,
    comment VARCHAR(500) NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users (user_id),
    FOREIGN KEY (video_id) REFERENCES videos (video_id)
);

CREATE TABLE likes (
    like_id BIGSERIAL NOT NULL PRIMARY KEY,
    user_id BIGINT NOT NULL,
    video_id BIGINT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users (user_id),
    FOREIGN KEY (video_id) REFERENCES videos (video_id)
);

CREATE TABLE libraries (
    library_id BIGSERIAL NOT NULL PRIMARY KEY,
    user_id BIGINT NOT NULL,
    video_id BIGINT NOT NULL, 
    FOREIGN KEY (user_id) REFERENCES users (user_id),
    FOREIGN KEY (video_id) REFERENCES videos (video_id)
);