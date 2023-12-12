Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NYLUScjO"
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19952D0
	for <linux-hardening@vger.kernel.org>; Tue, 12 Dec 2023 13:20:20 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1d343f8e139so6165285ad.0
        for <linux-hardening@vger.kernel.org>; Tue, 12 Dec 2023 13:20:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702416019; x=1703020819; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o4PtHmb7h7cjkMdU7+gili3cUJ8EUgY6EkxjVCjKgrI=;
        b=NYLUScjO2XHVuAXl4F9gnGJv8CZ+pd2VksCe+NeS5ye6KyDTjRizOhOX8j71SQY5Dy
         0Nz2H4LlieKUYxGIvH0QIB3Sl1p+Gd9xI+hRA5w1L/5HaekbPRUV3WLRRZ3mkWvPwipf
         2SDuc5LQM9k0R8tLoimKfPabW4WpUPaPp7G2U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702416019; x=1703020819;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o4PtHmb7h7cjkMdU7+gili3cUJ8EUgY6EkxjVCjKgrI=;
        b=nGl64yXC8nk5kxcw2JQsyk+/I3OqoTPEOZWwe1OtkJpZm8f9KK6bqHGoR0gn/M6M7Q
         tT+tA7HdMukgqm7qFlp3nL6bZqepv1e7MbzYAs9jNCmdhJE0VpnPlzvAg1Lq/7c2vQ2+
         6kGFOYgSi+gSoV+D5hx3bETxOaWJjK2XqMXr2jvjJLX2XAvKDITC1D8V7vi4foOGR/35
         D7qypLgvN7vnZ9cgkXEjSRlwEUG+J/nCf/DYOso+97c6RWMTCocp6bTdO3nKtdA1Q6G7
         r4YkOsa9poaL+s40frmKj4KKryH+zbcWAN2e2rBkrBkJHE6OkMwFgNnoHv7XOrEiplvB
         nXKQ==
X-Gm-Message-State: AOJu0YwzfZUd8e5MdUeLRz2ylEov12IuyOdX33bIlbSp5vZLN/VHqUHs
	Ctpc6JdaNIvyYzEi975TCm+bR4Hx8xIu35andPw=
X-Google-Smtp-Source: AGHT+IFlDS2uaGb+KjVZJ4SyvoBSZrz/iRr5YDrQNhwh54rEmgWqvkqV+B1gwdtK5G+Q3dAMbqwDDQ==
X-Received: by 2002:a17:902:650f:b0:1d3:3a5d:d5d3 with SMTP id b15-20020a170902650f00b001d33a5dd5d3mr693274plk.19.1702416019386;
        Tue, 12 Dec 2023 13:20:19 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id p17-20020a170903249100b001cfbe348ca5sm9066719plw.187.2023.12.12.13.20.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 13:20:18 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Anders Larsen <al@alarsen.net>,
	Kees Cook <keescook@chromium.org>
Cc: Ronald Monthero <debug.penguin32@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 0/2] qnx4: Avoid confusing compiler about buffer lengths
Date: Tue, 12 Dec 2023 13:19:39 -0800
Message-Id: <170241597608.164694.1762861756800879766.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231130205010.it.412-kees@kernel.org>
References: <20231130205010.it.412-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 30 Nov 2023 12:51:17 -0800, Kees Cook wrote:
> This attempts to fix the issue Ronald Monthero found[1]. Avoids using a
> too-short struct buffer when reading the string, by using the existing
> struct union.
> 
> -Kees
> 
> [1] https://lore.kernel.org/lkml/20231112095353.579855-1-debug.penguin32@gmail.com/
> 
> [...]

I'll put these in -next since there's been no more discussion on it.

Applied to for-next/hardening, thanks!

[1/2] qnx4: Extract dir entry filename processing into helper
      https://git.kernel.org/kees/c/49a85c02a189
[2/2] qnx4: Use get_directory_fname() in qnx4_match()
      https://git.kernel.org/kees/c/0a0fb20f5e08

Take care,

-- 
Kees Cook

