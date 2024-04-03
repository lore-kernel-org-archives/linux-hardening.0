Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B705200D4
	for <linux-hardening@vger.kernel.org>; Wed,  3 Apr 2024 13:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712150110; cv=none; b=WsNbdRKdLI/jkXfvJskDL5rbK4FnAU/S6c3XxfJmxPUn5FS4xl77hHapmiZnXeQQ6XL0DBZCJhjvqjoC1JIyYndu+WKh+HvzjU3AuVF68UUWOToBPyTbx0jt82lhimpedebv67hjjCYcAptT1QVwvf+m4DevtWHXSKVE08v1SRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712150110; c=relaxed/simple;
	bh=m8vRG88FNKwizdEjO/c/t64mIYd2qCldOAH8zF37jpU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NeLswsoQkJkoym8tBzz85uOU0OwAGFUuRfnSpk3ujHdH0cb20FEvsvvyov+qVGH1cgIS1nMN9txVYrwmgxDy3yGYzwBvVIUJ5Yh1G6+pcatKNn/XHaP3gGhXKcWFF+Ev0moRExQO7n9HgZnkOzgrS3H3/LxnWTFoPmeXx/MZOWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omnibond.com; spf=pass smtp.mailfrom=omnibond.com; dkim=pass (2048-bit key) header.d=omnibond-com.20230601.gappssmtp.com header.i=@omnibond-com.20230601.gappssmtp.com header.b=cqYY4M1g; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omnibond.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omnibond.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=omnibond-com.20230601.gappssmtp.com header.i=@omnibond-com.20230601.gappssmtp.com header.b="cqYY4M1g"
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5a4a14c52fcso3560884eaf.1
        for <linux-hardening@vger.kernel.org>; Wed, 03 Apr 2024 06:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=omnibond-com.20230601.gappssmtp.com; s=20230601; t=1712150107; x=1712754907; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sPbrOyf+WH3LEFByBVjd+RN6Vyy+2vOeO98hIRaqQ9s=;
        b=cqYY4M1g+b8WUZFExEXo/50OWYWU9KBmNSevCfHbEyA+vcxVnl8+oVxvBM1sCtBsbu
         zKevR2dA69np57NkONLQcmPkt/D2Qk2Iis8pVs1xhuciVjiB1EQO29GnoTisTOYXi9ct
         E4RoBSDG+kRRDugaDdCN18pNrFqFYVCqimMWM6dk6JkuPFn8N0IbrnTwDeWtaq/wAWxg
         ftovQTLgAcZN4372gT2t/EV1eELtitRXYVz1SsEB66DH0ZiFxm2T2thd8Afl4jYWKx2I
         3VTG7AGbhVACwqH1Y3A8x8r6+4nkGRcg9ipiHTwtqkiKo4AXJhv4A9hIdApLwRJcTXhy
         cJJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712150107; x=1712754907;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sPbrOyf+WH3LEFByBVjd+RN6Vyy+2vOeO98hIRaqQ9s=;
        b=s5gDcNCaSYZgtj2fG7G9sSxeB9AUvtjr/P2phYAwVJ9o1RmUbW8+JiXfp9E9amFAZU
         y2nJAMG+ozLNz/seqMEH94ztqrjFLm8SIWTPv9W43OGuLAsCaNbRGatVTUVf6zlkMsQJ
         Sd+NouB11+4uj9jR1ZYjH0M6UHB+/uURx5mybFkVSYoVwLUUKxN95w8yTBLCblKJ8x5k
         d+Qf8OhoIK0qQHmItzZ64HuMJMirfh+cqWNM1emlOdjZuX4V+csqVFaBOaZutGQPRXK1
         4j9g7loH3DwCq2wCS/u66LFnv+6KGwiWCA2zuiEX/8ozyyMkDYDPdUSuX2rO1L0gCCAd
         EA6A==
X-Forwarded-Encrypted: i=1; AJvYcCWwzEq2jpwbslqC466v+v8AyVw0T1c3h9Wf4pNM6oFRUkjIbgSZnw2B+wrQxllmVD+EFto17IS/09Wk9Z5ZJ/Qgyn5Cnc57dWAYLgWycM/F
X-Gm-Message-State: AOJu0YxfEHe6zsgYm74ol9C9jmkfiLCT2yFW9AbE5sZtMu4C6bDBl8tZ
	/w4Ep2586/OR+CZxkPO+l1U1yt/DP+9HljmusacRY82DGMESRbje59v56ITbKTnq68yCnEqCF/1
	6AyVRxGm9R7ebLY2Vny9W9gmSnIDQH72LdBLU
X-Google-Smtp-Source: AGHT+IHynG/6vnesdgrFbSespFgf+tjzJxeuEecAnZ9LoEzbZsyl/DJ98pbGh+3WDjfxscRbv5KPEGx2DICPSrmMYeg=
X-Received: by 2002:a4a:dc98:0:b0:5a4:ae86:118f with SMTP id
 g24-20020a4adc98000000b005a4ae86118fmr11506801oou.8.1712150107554; Wed, 03
 Apr 2024 06:15:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240322-strncpy-fs-orangefs-dcache-c-v1-1-15d12debbf38@google.com>
 <20240401-redewendung-retten-132ff0ea272d@brauner>
In-Reply-To: <20240401-redewendung-retten-132ff0ea272d@brauner>
From: Mike Marshall <hubcap@omnibond.com>
Date: Wed, 3 Apr 2024 09:14:56 -0400
Message-ID: <CAOg9mSRa0PnFHSJAjOO=kjJKEG1_usREYO5QM+_Wt0VYsbVf8w@mail.gmail.com>
Subject: Re: [PATCH] orangefs: cleanup uses of strncpy
To: Christian Brauner <brauner@kernel.org>
Cc: Martin Brandenburg <martin@omnibond.com>, Justin Stitt <justinstitt@google.com>, 
	devel@lists.orangefs.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, 
	Mike Marshall <hubcap@omnibond.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi...

I b4'd this patch (I love b4) and applied it to 6.9.0-rc2
and ran it through xfstests with no regressions, so please
add a tested-by for hubcap@omnibond.com.

Thanks...

-Mike Marshall

On Mon, Apr 1, 2024 at 4:53=E2=80=AFAM Christian Brauner <brauner@kernel.or=
g> wrote:
>
> On Fri, 22 Mar 2024 21:41:18 +0000, Justin Stitt wrote:
> > strncpy() is deprecated for use on NUL-terminated destination strings
> > [1] and as such we should prefer more robust and less ambiguous string
> > interfaces.
> >
> > There is some care taken to ensure these destination buffers are
> > NUL-terminated by bounding the strncpy()'s by ORANGEFS_NAME_MAX - 1 or
> > ORANGEFS_MAX_SERVER_ADDR_LEN - 1. Instead, we can use the new 2-argumen=
t
> > version of strscpy() to guarantee NUL-termination on the destination
> > buffers while simplifying the code.
> >
> > [...]
>
> If this needs to go separately from the vfs trees let me know.
>
> ---
>
> Applied to the vfs.misc branch of the vfs/vfs.git tree.
> Patches in the vfs.misc branch should appear in linux-next soon.
>
> Please report any outstanding bugs that were missed during review in a
> new review to the original patch series allowing us to drop it.
>
> It's encouraged to provide Acked-bys and Reviewed-bys even though the
> patch has now been applied. If possible patch trailers will be updated.
>
> Note that commit hashes shown below are subject to change due to rebase,
> trailer updates or similar. If in doubt, please check the listed branch.
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
> branch: vfs.misc
>
> [1/1] orangefs: cleanup uses of strncpy
>       https://git.kernel.org/vfs/vfs/c/fc10fed37526
