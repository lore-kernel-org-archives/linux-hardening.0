Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78BB2EB86E
	for <linux-hardening@vger.kernel.org>; Tue, 19 Aug 2025 19:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755630098; cv=none; b=IVVTiDEmyRG3QnJ16fMRtEnV+qot/0YlNEBK6FvWJi9H5hIwj97do1rZHw1YGw8JZqMiBkTA72GnkqYhxKAwye97aRneIS0PAtIC2vlQhjetXnlbXUoVxBZJf/1fmLI3x3brSiHIbw+p4uFuloJsJpQzfCroRNmX+/L2Ugg/wu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755630098; c=relaxed/simple;
	bh=4uWhrX/2mNAcS/gMBK/6vJDEGnvfAe/pLU7PZA5FgBQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZTtWXPyLFBqZE9yn2axLHr2m88WqYGU6z1cHtnAStxpZq2JB/Hok4kg1dseqAkerEYXET9f/s0LebR01tDXcKWeqa6ovWO4d2p85ViywSroNSq/eB02EQHKNtldJPm4XG+oq98EWtLf/KGpCGJhJWnuQ+4YgpbUV6nK1KL1/LOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MjlNt0fb; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MjlNt0fb"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-244581caca6so43925725ad.2
        for <linux-hardening@vger.kernel.org>; Tue, 19 Aug 2025 12:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755630095; x=1756234895; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8qvuArYaZMFJV1RHzhtqqlTOKt/BCHit5YfuHRk9sg0=;
        b=MjlNt0fbUvuhz2Ygws2evfcA+L458A8/0Cpk6w9ZMa52adsSC0TdwxlPVNcrSkbp6U
         VZqKaCHruJSd8msKcMIBRnznkW91bbzHNLTJvOhvaqLBsyZOfYAMcmn9/BLqbWFnv5q/
         zV/PJGR+GqrlYoKwhO8bkJl0zAkG8FV5UDSjrCShvINmBoj4OK+yWEYFWy1Mbl5Wnb3x
         rm+4+WdaQu4/woy5SdOsxruYHypXd4p8ZK/sCzP0l0sm5bVFmja4BwaMSr3EwnT5KAeL
         aA5po0NmIH9VwMqwxlYiecITI2EGaS6zBtd3Ka94ybzSPcTlDf+MyP701+dCFfiqYeVY
         44jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755630095; x=1756234895;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8qvuArYaZMFJV1RHzhtqqlTOKt/BCHit5YfuHRk9sg0=;
        b=pQlLkUNTAVSg0h+ZkZkFeF55Hox9n2BVPRPu8KpckdbmWm3rixdzEfiR59XgYwUF32
         2P5euyLI4VkwUkVetU01vRniyI/tROREPSsvM8YaBsDLSB5iMHsOQrqyQK3ScfdLs3/A
         FMfwscxpYA/fmMeB27U5nbLWEtLQNq9nZuh91/vGbJYNTqFaNa2/p6HjuAf1H91UdZiB
         m2OMpD6zEYJBJYKYtL2H/v8t18E10qRWRd4hjhMTLyRurGXJoux6RuZJwDRLLAvhWPux
         b7PidiEh0aKMfyoX0NtILbMciSi/3LWtM7CVvGlksAKBtwx54asBGfskthU1GvdqTHmm
         IS4A==
X-Forwarded-Encrypted: i=1; AJvYcCXIz74SwYOWC5/xiursisAZPqZD03lyXtqTIAz7fk+334kYfiU6N8CKTaV40zGitd0Q0i/VtzOnzQ//46TTX9k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQAusbv9Q051+xCNrvznCl2tP/HaYjKMdgHHJGEfAj48T24CxN
	77WfCUBgtN9Bg5vQ18CJ2beTTGVvgAbgA+eO64YGK8U4lFVm3noUg7Id3KzPCpgK9fNLMa+Gz/z
	5rgeagZgS6Wf0eTy8Y5VyRWzjLfih0fWh7zF3dFx1
X-Gm-Gg: ASbGnctLItcmylTvscwXFxVLgppTZR2Nf/P+yTzJmgkKllkrbOnwBZ6a86wwJlL9kig
	Dhg9WP+VMxUA/mreIaBG61xr3EncXfFpsNIO64T+8Y+GFpAAnkAa7FnqrnUvpHiNRf8zyKvuwLI
	bINFCXF7nFPfepgdjqSLWFUOTJjWh0RyNkBPwKD2V2TYmpRx90mVpuGVYerli4SieFeTWjD1g65
	wukPIiWX9/u6GzZEz39o9tJPYCbG/oOVD5LPJ6H38Ct
X-Google-Smtp-Source: AGHT+IE/w9Ed+cmdAkyXk323HUtGTRtDIoia0hEETGRFT1hPBd7ibD+QoVmW4KplXUj3MKNL/ms1zGGJh8UY8mXETjM=
X-Received: by 2002:a17:902:ce01:b0:235:f078:4746 with SMTP id
 d9443c01a7336-245ef25bb33mr618995ad.42.1755630094952; Tue, 19 Aug 2025
 12:01:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250815213742.321911-3-thorsten.blum@linux.dev>
In-Reply-To: <20250815213742.321911-3-thorsten.blum@linux.dev>
From: Marco Elver <elver@google.com>
Date: Tue, 19 Aug 2025 21:00:58 +0200
X-Gm-Features: Ac12FXwZea5-tAvhMnunHuHJNaxPoH5DoA6U1F3MtQeyJo61FGS19PYEFJ-wqmY
Message-ID: <CANpmjNOLKQsVTvqV+OdMrNOaHoWnUq1TU-nTRBKGCzY87E7xUw@mail.gmail.com>
Subject: Re: [PATCH] kcsan: test: Replace deprecated strcpy() with strscpy()
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Dmitry Vyukov <dvyukov@google.com>, linux-hardening@vger.kernel.org, 
	kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 15 Aug 2025 at 23:38, Thorsten Blum <thorsten.blum@linux.dev> wrote:
>
> strcpy() is deprecated; use strscpy() instead.
>
> Link: https://github.com/KSPP/linux/issues/88
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

Reviewed-by: Marco Elver <elver@google.com>

Taking this into the -kcsan tree, but might be a while until it hits mainline.

> ---
>  kernel/kcsan/kcsan_test.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/kcsan/kcsan_test.c b/kernel/kcsan/kcsan_test.c
> index 49ab81faaed9..ea1cb4c8a894 100644
> --- a/kernel/kcsan/kcsan_test.c
> +++ b/kernel/kcsan/kcsan_test.c
> @@ -125,7 +125,7 @@ static void probe_console(void *ignore, const char *buf, size_t len)
>                                 goto out;
>
>                         /* No second line of interest. */
> -                       strcpy(observed.lines[nlines++], "<none>");
> +                       strscpy(observed.lines[nlines++], "<none>");
>                 }
>         }
>
> @@ -231,7 +231,7 @@ static bool __report_matches(const struct expect_report *r)
>
>                         if (!r->access[1].fn) {
>                                 /* Dummy string if no second access is available. */
> -                               strcpy(cur, "<none>");
> +                               strscpy(expect[2], "<none>");
>                                 break;
>                         }
>                 }
> --
> 2.50.1
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion visit https://groups.google.com/d/msgid/kasan-dev/20250815213742.321911-3-thorsten.blum%40linux.dev.
