Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7FA156F29
	for <linux-hardening@vger.kernel.org>; Tue, 23 Jul 2024 18:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721759454; cv=none; b=nixBqdheRxGzwjGNAXoTL9nF0t62FJTWXp5N4JCwNH7B6c6K9mqkWwX+Oo4JvI5ejmzkcC7Xn75kXiVDf4FkNejE76I6dpnuzP9egVVLBh0Yij3upBYlSxq1hq6SAnGt4XHizoXIp7JrJWYTqkUc/YpLC1URjYG1gnd33dlmm7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721759454; c=relaxed/simple;
	bh=Pp3VZCk6dq4+5Vpj+kfpnKF3kGHUtiSO1r77QnLX328=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WSlhbGxFJk0uPwiiRYa5guESGc1qftGucV5suJ6exibRuInzZXvJGfCgkUwrI0WKoGQoF8xKIM2jYcZESKc+vPRmVO3vUGavdivfWTQtHKPP7bwJjxc2tjLi8EhQDmQlu3KIQq3EAsLS9r0KFii2uvBAJMZD8cKQigRcxhTlBzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Uqj5nVBU; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Uqj5nVBU"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52efbc57456so1876149e87.1
        for <linux-hardening@vger.kernel.org>; Tue, 23 Jul 2024 11:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1721759450; x=1722364250; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hbXsSOOY+gKi86u1NQNhucpEoLXztu3BNQ9K2X48C04=;
        b=Uqj5nVBU7Bn/TNuydEGRewUhk6xYLTh7bh/+y/BedcKtRNX1sL0f3HIb5e6PvUNcIr
         O72G47BuYMAClR2SaDrawb+rFR8z1PxgxrJUshYYo2ApixOmfkZXwk0s+eEf3lkzWtyE
         QY4V+dYqGi8cBu5ctuePXlSTECFICtSq5iYOk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721759450; x=1722364250;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hbXsSOOY+gKi86u1NQNhucpEoLXztu3BNQ9K2X48C04=;
        b=TnFzDURiGdlEndoMVO6T/uNt7tdEklIRCrbIxr3mrwKBY9x3ck0HjozB7LtzD8gOwa
         OiLRB/JpQ08FlqWzSCEGJe8pl3XESTkaH7ZDE8U4tQHS404xjNJLOzm4Fsb0FfZQ4GTZ
         DjKD8iy29po8iE64bjkbp+47eedR7enNT+D5Wi98qbmy6+Ua1BQwqmvf2UvoqD3kstLq
         wMW2dx42IDlaF/DwIBUxY+zZUc/v7OJCVDMUOyy8OduotjlTXDIjyfsm/TNXeGAppxMm
         KC+PPtSQE3I5XtJ5tDW+lqhObxNPrl+L978P8gbZwFhcH3tMrs9chOBe4w4eiqLJbKAk
         5SJA==
X-Forwarded-Encrypted: i=1; AJvYcCVb6UMKrVG8Gu+jTxwTE14ijj4RJXOB0Xq1PBKEahjddwQ0LT+TM+3mx4nv8VOEQPvrLvygGFafzV8NYo62JX4dnZU1U331LD0Ng5Vtjgdu
X-Gm-Message-State: AOJu0YyQUzF24t1mBXtQbpplny2z77ksQyeLphc5hiht//ARzpGKqSUi
	n8FpItcoY52Eb1KX8lzmublSLuV/rv4sfR6Eip+a2nFwLK3tVIIYb/eVp/3Ln0oJr95CJJIKwAc
	5zp0=
X-Google-Smtp-Source: AGHT+IGyqbkhlAKZyV2feQ6soG6G/40gWG7CX6TsPallmAkCUfEIESMhlkKj8fUkA4AAuhE5OGtO6g==
X-Received: by 2002:a05:6512:3ba7:b0:52c:d80e:55a5 with SMTP id 2adb3069b0e04-52fcda50270mr341260e87.41.1721759450268;
        Tue, 23 Jul 2024 11:30:50 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52efbb6ba6csm1340600e87.156.2024.07.23.11.30.48
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jul 2024 11:30:49 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-52efbc57456so1876114e87.1
        for <linux-hardening@vger.kernel.org>; Tue, 23 Jul 2024 11:30:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW3bPXtD1kt6RQ+DqdA725WZMTkb4cfA+7SRiToHBm6n4HBrGlcqPQCRL4XKD5904nsaqvU6RS/Syv/xwi8NvaDmwjsfjUyW7AX2Ud0BOot
X-Received: by 2002:a05:6512:3d26:b0:516:d219:3779 with SMTP id
 2adb3069b0e04-52fcda6533cmr227963e87.58.1721759448531; Tue, 23 Jul 2024
 11:30:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240723171753.739971-1-adrian.ratiu@collabora.com>
In-Reply-To: <20240723171753.739971-1-adrian.ratiu@collabora.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 23 Jul 2024 11:30:31 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiJL59WxvyHOuz2ChW+Vi1PTRKJ+w+9E8d1f4QZs9UFcg@mail.gmail.com>
Message-ID: <CAHk-=wiJL59WxvyHOuz2ChW+Vi1PTRKJ+w+9E8d1f4QZs9UFcg@mail.gmail.com>
Subject: Re: [PATCH] proc: add config & param to block forcing mem writes
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	kernel@collabora.com, gbiv@google.com, inglorion@google.com, 
	ajordanr@google.com, Doug Anderson <dianders@chromium.org>, Jeff Xu <jeffxu@google.com>, 
	Jann Horn <jannh@google.com>, Kees Cook <kees@kernel.org>, 
	Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 23 Jul 2024 at 10:18, Adrian Ratiu <adrian.ratiu@collabora.com> wrote:
>
> This adds a Kconfig option and boot param to allow removing
> the FOLL_FORCE flag from /proc/pid/mem write calls because
> it can be abused.

Ack, this looks much simpler.

That said, I think this can be prettied up some more:

> +enum proc_mem_force_state {
> +       PROC_MEM_FORCE_ALWAYS,
> +       PROC_MEM_FORCE_PTRACE,
> +       PROC_MEM_FORCE_NEVER
> +};
> +
> +#if defined(CONFIG_PROC_MEM_ALWAYS_FORCE)
> +static enum proc_mem_force_state proc_mem_force_override __ro_after_init = PROC_MEM_FORCE_ALWAYS;
> +#elif defined(CONFIG_PROC_MEM_FORCE_PTRACE)
> +static enum proc_mem_force_state proc_mem_force_override __ro_after_init = PROC_MEM_FORCE_PTRACE;
> +#else
> +static enum proc_mem_force_state proc_mem_force_override __ro_after_init = PROC_MEM_FORCE_NEVER;
> +#endif

I think instead of that forest of #if defined(), we can just do

  enum proc_mem_force {
        PROC_MEM_FORCE_ALWAYS,
        PROC_MEM_FORCE_PTRACE,
        PROC_MEM_FORCE_NEVER
  };

  static enum proc_mem_force proc_mem_force_override __ro_after_init =
      IS_ENABLED(CONFIG_PROC_MEM_ALWAYS_FORCE) ? PROC_MEM_FORCE_ALWAYS :
      IS_ENABLED(CONFIG_PROC_MEM_FORCE_PTRACE) ? PROC_MEM_FORCE_PTRACE :
      PROC_MEM_FORCE_NEVER;

I also really thought we had some parser helper for this pattern:

> +static int __init early_proc_mem_force_override(char *buf)
> +{
> +       if (!buf)
> +               return -EINVAL;
> +
> +       if (strcmp(buf, "always") == 0) {
> +               proc_mem_force_override = PROC_MEM_FORCE_ALWAYS;
 ....

but it turns out we only really "officially" have it for filesystem
superblock parsing.

Oh well. We could do

  #include <linux/fs_parser.h>
 ...
  struct constant_table proc_mem_force_table[] {
        { "ptrace", PROC_MEM_FORCE_PTRACE },
        { "never", PROC_MEM_FORCE_NEVER },
        { }
  };
  ...
  proc_mem_force_override = lookup_constant(
        proc_mem_force_table, buf, PROC_MEM_FORCE_NEVER);

but while that looks a bit prettier, the whole "fs_parser.h" thing is
admittedly odd.

Anyway, I think the patch is ok, although I also happen to think it
could be a bit prettier.

            Linus
