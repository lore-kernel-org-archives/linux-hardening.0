Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896242BDC21
	for <linux-hardening@vger.kernel.org>; Fri, 15 Aug 2025 08:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755248227; cv=none; b=ZrHkNZKNJWCAYa3l3q4WXUmnL3kVYJVEtjNW7GrXGcJFrvHYzZxCVsPsOGn/trM06tpIQkNoRpSIuLcY2XgAZvyC4Qsr6xmJR3IJvRXfHHNuRhYM4ozR1/UxXPM81hhTA0fjJhJEDQkihkHPBWNKvGSib851tPt/rk/jXJw56nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755248227; c=relaxed/simple;
	bh=O+ZJhafHbN8qKN4icGVFVJdf7Wc38og21IDtrgf6xHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pBcWrc0kLX5iVtXZItBAuuWCZKh+8iGHU3d8ZgDnp6cB5QeXjhVz6uCrd1/Y12AUXanTTljALGz1R13mTS+q7QVpxSKc56F4T25z00O2Rq9B/yuKlnGjPhe0ZBzhhLoojcz/+WeeCb+R9UcR4yT7ynwPIyB5Jn9uCQhtgVEMc8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=Fr8hMHLH; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="Fr8hMHLH"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3b9dc5c6521so997358f8f.1
        for <linux-hardening@vger.kernel.org>; Fri, 15 Aug 2025 01:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1755248224; x=1755853024; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9BVLRS1doEc+x07yv9mxCetgtRilsR775nABol27HW0=;
        b=Fr8hMHLHFrSsBH9l/bO6eW28nYHZtMvryID8AI2vLYfKQtkM+iPi9bwffn8xFEXbcs
         QZzLq92Gr8EGi3jbIKt2NwdxO9G62OeEQ4LKAldOZOd+c3B1DNG8Nae3JWfOO20s/iRb
         d6mlVbAY09e9ctoTyxbfGwCcA9j1PeeFQbThwbJSRCSV6RLjn8Y1bs0qdIWWpKf69XeA
         roh1yhn6YYTDYPoOXhggzyH7MOAcGtO3SG8E3hxfG0cQLLptrWmAkUHSImM/2Kx1TISM
         HYyTkDBDA18/vQKh/iLc54ZQj7SH+DHIbCo8bNHBUEN0uP6/Yjx4rJ9Z0NobFMQAasix
         8d3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755248224; x=1755853024;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9BVLRS1doEc+x07yv9mxCetgtRilsR775nABol27HW0=;
        b=s37OmZ1ebJwlZHMrJt9kdAqlTaxBLreAM20GbJlz0qHWmAXuYyV3MFJ/TGAh+Iaq4t
         gJ/HCfRAVewxmG61/ZU1EDA7IspaNF+x9VAx7Yu1DHqdPJFjmfvCI1g3T8X1Z57ilBCm
         HzyzQC5NFbYaJRm3/AkR0JENXw5QgtJtpYMjNJJ8HtA+P7EoPCEVBQhZ0r5GyoQRwJHJ
         rVxGVClIe0XIzJQYjDnCxgDPLz2CDzQFctM2bvdmOz1aM+yQSnrr0GgQIC6zvbJmWnsz
         xcCtE6Z+tin7IIyJ5L5GDbZH8DD18OmPOJdTq+z1JEag3fsjc/2hplzBV2w3JL5u0r30
         70fw==
X-Forwarded-Encrypted: i=1; AJvYcCX1FfPkHfBKJS1ii9ZlbrEEY5d9iR6bcT2a2nDhiomhOQjWAgXD7BVgzUkAWTvGzuGU6eUCWos9H85ofhYNbMk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKwp4K4RBldBgvPwfn/NYl9L3YLrequ3W88MpsSkgb26Zh3uUG
	SHRfEs8e5xiljQliUFc6GNH0G6wDRiHPye4BY4ZhbnjHjsCv3NEm26AEUZn4MgNqnMs=
X-Gm-Gg: ASbGncs8pnmSxTPNZZrjyAOi+29f9PZT08lbb4MeBKCEuGw+ctGYzujkVGUkJ6/R5EH
	1ZUIgbbhzVlptMTkfqrJEf7DHiW3SCcetVaEE71Zz+AymY7DAfWM42ESkLPWBX3WsYMmpdgpg3K
	/EdCzTYtKwC1ZUluUFxm9+jS44Ksq7UgPKj8au38JOVSgpP+4hglkDQVcsmyl71Yo6iP+tm5s9q
	KCgjbzl0IgyADerD5UGJhGjPOB/1pmPXYGul8O1owxLzvtObJFlUA8zpoZo4Wbz7Cu39yYT9HRv
	gdeur9KKovTCHbME8z3wP818LHtuXTMy4AXJCmDlfxu7ZZeu0n+2jV95Uje+uLiLvlm1OYT4bTW
	EiQ/ASdckHEq72u+F1rqlX/IOqLW0Zkbi5N2EuwmUku5SpHoi10g3ROS+EmmuDxgMq/Uf4lzCR8
	OvVA7UXQ==
X-Google-Smtp-Source: AGHT+IFvt9mkLof/lJEoZmg1BE+vZmNTLjleKp492QP8YOt1wf51xs/Bcjh+MMEioORGgWasXnvAWQ==
X-Received: by 2002:a5d:588e:0:b0:3b9:10c5:bd7d with SMTP id ffacd0b85a97d-3bb6636cb2fmr1029382f8f.10.1755248223713;
        Fri, 15 Aug 2025 01:57:03 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3bb6863fc29sm1161346f8f.66.2025.08.15.01.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 01:57:03 -0700 (PDT)
Date: Fri, 15 Aug 2025 09:57:01 +0100
From: Daniel Thompson <daniel@riscstar.com>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Jason Wessel <jason.wessel@windriver.com>,
	Daniel Thompson <danielt@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	Nir Lichtman <nir@lichtman.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Yuran Pereira <yuran.pereira@hotmail.com>,
	linux-hardening@vger.kernel.org,
	kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] kdb: Replace deprecated strcpy() with strscpy() and
 memcpy()
Message-ID: <aJ72XZ0VkrCkKFNy@aspen.lan>
References: <20250814220130.281187-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814220130.281187-2-thorsten.blum@linux.dev>

On Fri, Aug 15, 2025 at 12:01:28AM +0200, Thorsten Blum wrote:
> strcpy() is deprecated; use strscpy() and memcpy() instead and remove
> several manual NUL-terminations.
>
> In parse_grep(), we can safely use memcpy() because we already know the
> length of the source string 'cp' and that it is guaranteed to be
> NUL-terminated within the first KDB_GREP_STRLEN bytes.
>
> No functional changes intended.
>
> Link: https://github.com/KSPP/linux/issues/88
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
> Changes in v3:
> - Extract the strscpy() changes into a separate patch and focus on
>   replacing the deprecated strcpy() calls as suggested by Greg
> - Link to v2: https://lore.kernel.org/lkml/20250814163237.229544-2-thorsten.blum@linux.dev/
>
> Changes in v2:
> - Use memcpy() instead of strscpy() in parse_grep() as suggested by Greg
> - Compile-tested only so far
> - Link to v1: https://lore.kernel.org/lkml/20250814120338.219585-2-thorsten.blum@linux.dev/
> ---
>  kernel/debug/kdb/kdb_main.c | 14 +++++---------
>  1 file changed, 5 insertions(+), 9 deletions(-)
>
> diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
> index 7a4d2d4689a5..40de0ece724b 100644
> --- a/kernel/debug/kdb/kdb_main.c
> +++ b/kernel/debug/kdb/kdb_main.c
> @@ -727,14 +727,10 @@ static int kdb_defcmd(int argc, const char **argv)
>  	mp->help = kdb_strdup(argv[3], GFP_KDB);
>  	if (!mp->help)
>  		goto fail_help;
> -	if (mp->usage[0] == '"') {
> -		strcpy(mp->usage, argv[2]+1);
> -		mp->usage[strlen(mp->usage)-1] = '\0';
> -	}
> -	if (mp->help[0] == '"') {
> -		strcpy(mp->help, argv[3]+1);
> -		mp->help[strlen(mp->help)-1] = '\0';
> -	}
> +	if (mp->usage[0] == '"')
> +		strscpy(mp->usage, argv[2] + 1, strlen(argv[2]) - 1);

Sorry but a strscpy() where the length of the destination buffer has
been calculated from the source string is way too much of a red flag
for me.

Put another way if there are "no functional changes intended" then there
cannot possibly be any security benefit from replacing the "unsafe"
strcpy() with the "safe" strscpy(). Likewise abusing the destination
length argument to truncate a string makes the code shorter but *not*
clearer because it's too easy to misread.

In this case even adding a comment to explain the abuse is pointless:
if you want to get rid of the strcpy() then do it by eliminating the
need to copy the string in the first place (e.g. make
kdb_strdup() duplicate the part of argv[2] that you actually want to
keep).

> +	if (mp->help[0] == '"')
> +		strscpy(mp->help, argv[3] + 1, strlen(argv[3]) - 1);

Better yet add a kdb_strdup_dequote() helper so the same bit of code can
be used in both these cases!


Daniel.
