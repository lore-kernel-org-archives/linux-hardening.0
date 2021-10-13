Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C52A4C4332F
	for <linux-hardening@archiver.kernel.org>; Wed, 13 Oct 2021 17:53:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A597C60FDA
	for <linux-hardening@archiver.kernel.org>; Wed, 13 Oct 2021 17:53:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238172AbhJMRzo (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 13 Oct 2021 13:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238200AbhJMRzn (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 13 Oct 2021 13:55:43 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD599C061746
        for <linux-hardening@vger.kernel.org>; Wed, 13 Oct 2021 10:53:39 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id d9so13491147edh.5
        for <linux-hardening@vger.kernel.org>; Wed, 13 Oct 2021 10:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aLaYS9RXqNt7+hFwlO6gsKYZWSmRQqVaqX+hEJqB9LM=;
        b=xKey7FWoKrUCv8IvtxRentW1ZmNn3JSpGsLpA2udEtATxoIGbSXEjH+SSpjwExDslC
         d+h4PmQCK2gG3F9s49Cfwd/Hyp/+uGQiyhKkvstRVmfUjpCLXom6QKI6qYkOmSSRm1an
         5MPW67g9kXLDgFZ+fw3p5THkh8wGt3zKPpLHASmMfIpUXMEzwzij8u4es9Bh+PITik1a
         94mEzYi/57g6QtmHRg4CQNgkqCLIfUl21ck/+j+Ek7i82MeG0pX2vdRqJilrqmYh5f4j
         UyTT+JRJjjtRNWDFC43CwLfVCddlKhuEOjZRwsgE/1+69lbzCJuGtSMf3AA/SS/cKzF2
         f/sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aLaYS9RXqNt7+hFwlO6gsKYZWSmRQqVaqX+hEJqB9LM=;
        b=Xd9BswxgP1ZAgcfkEU0fkyzYtO6zp06yYvUEssR8mpryq8n4hd+VnxRjKb2WseFqgT
         Ef/2+XdR0uycT7yjf7DXmG4juESWax1RTGqCivZhIT8Ytt2u7pwsO6QPzFTA40Q8dMLn
         0Z2LNMXU2N5hhxdPwYbbWcd6YN5WqsNapNJZDJ1DCIU4MJQsHrUWtVrr0RVzaWeKlBZu
         /CzHqnc9aYxd8aiKma7mHkygjKL5w8zQ/rQyDdF+xMSDh415EQa127a34OkAq/SH0fPs
         D790uHGCOoS1ow4ajn4SGy0EiJ+r/4WImvBm4CXt0G7peStV6p97o8wxXBd8KBA//nMv
         dHdQ==
X-Gm-Message-State: AOAM533KH7BpUZxsvpJBiQQZeNV4tY+AzgrU9JjCbEJKXiqlzxhK6w2d
        YXvbgYgQ8iXzAAFgIE4hJWEO3Wbt+7HBKywqg60w
X-Google-Smtp-Source: ABdhPJzxdv34rnUgFkzMsE+FKKRO+1gOHd0i8Ivdq0iHCNJpeRU70lMiFr2rZbn/NVPSyCVuYwZUPN/FflUsOTUSvek=
X-Received: by 2002:a05:6402:22d6:: with SMTP id dm22mr1120550edb.209.1634147618378;
 Wed, 13 Oct 2021 10:53:38 -0700 (PDT)
MIME-Version: 1.0
References: <20211013172847.1196305-1-keescook@chromium.org>
In-Reply-To: <20211013172847.1196305-1-keescook@chromium.org>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 13 Oct 2021 13:53:27 -0400
Message-ID: <CAHC9VhT0+omwDjqrJ2BtnRfa8SSGAkyUvB6WX95E=ntf9gUbmQ@mail.gmail.com>
Subject: Re: [PATCH] LSM: Avoid warnings about potentially unused hook variables
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        KP Singh <kpsingh@chromium.org>,
        linux-security-module@vger.kernel.org,
        kernel test robot <lkp@intel.com>,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Oct 13, 2021 at 1:31 PM Kees Cook <keescook@chromium.org> wrote:
>
> Building with W=1 shows many unused const variable warnings. These can
> be silenced, as we're well aware of their being potentially unused:
>
> ./include/linux/lsm_hook_defs.h:36:18: error: 'ptrace_access_check_default' defined but not used [-Werror=unused-const-variable=]
>    36 | LSM_HOOK(int, 0, ptrace_access_check, struct task_struct *child,
>       |                  ^~~~~~~~~~~~~~~~~~~
> security/security.c:706:32: note: in definition of macro 'LSM_RET_DEFAULT'
>   706 | #define LSM_RET_DEFAULT(NAME) (NAME##_default)
>       |                                ^~~~
> security/security.c:711:9: note: in expansion of macro 'DECLARE_LSM_RET_DEFAULT_int'
>   711 |         DECLARE_LSM_RET_DEFAULT_##RET(DEFAULT, NAME)
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/lsm_hook_defs.h:36:1: note: in expansion of macro 'LSM_HOOK'
>    36 | LSM_HOOK(int, 0, ptrace_access_check, struct task_struct *child,
>       | ^~~~~~~~
>
> Cc: James Morris <jmorris@namei.org>
> Cc: "Serge E. Hallyn" <serge@hallyn.com>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: Casey Schaufler <casey@schaufler-ca.com>
> Cc: KP Singh <kpsingh@chromium.org>
> Cc: linux-security-module@vger.kernel.org
> Reported-by: kernel test robot <lkp@intel.com>
> Link: https://lore.kernel.org/linux-mm/202110131608.zms53FPR-lkp@intel.com/
> Fixes: 98e828a0650f ("security: Refactor declaration of LSM hooks")
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  security/security.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Looks reasonable to me, thanks Kees.  Unless James wants to pick this
up for the security tree, I can pull this into the SElinux tree with
the io_uring change which is causing the testing robot to complain.

Acked-by: Paul Moore <paul@paul-moore.com>

> diff --git a/security/security.c b/security/security.c
> index 9ffa9e9c5c55..462f14354c2c 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -706,7 +706,7 @@ static int lsm_superblock_alloc(struct super_block *sb)
>  #define LSM_RET_DEFAULT(NAME) (NAME##_default)
>  #define DECLARE_LSM_RET_DEFAULT_void(DEFAULT, NAME)
>  #define DECLARE_LSM_RET_DEFAULT_int(DEFAULT, NAME) \
> -       static const int LSM_RET_DEFAULT(NAME) = (DEFAULT);
> +       static const int __maybe_unused LSM_RET_DEFAULT(NAME) = (DEFAULT);
>  #define LSM_HOOK(RET, DEFAULT, NAME, ...) \
>         DECLARE_LSM_RET_DEFAULT_##RET(DEFAULT, NAME)
>
> --
> 2.30.2

--
paul moore
www.paul-moore.com
