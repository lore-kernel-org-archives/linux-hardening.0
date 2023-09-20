Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6849C00E86
	for <linux-hardening@archiver.kernel.org>; Wed, 20 Sep 2023 15:38:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235278AbjITPiT (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 20 Sep 2023 11:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234619AbjITPiT (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 20 Sep 2023 11:38:19 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D80AA3
        for <linux-hardening@vger.kernel.org>; Wed, 20 Sep 2023 08:38:13 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1c5c91bece9so2900035ad.3
        for <linux-hardening@vger.kernel.org>; Wed, 20 Sep 2023 08:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695224292; x=1695829092; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KIlfnzN64vt0Db75ZI9wrazd3l6cBizkwl03TscBFBU=;
        b=grIImtQWNBz4O3VZ8lBD2vfKB4PkQhfq/SxGc4hh3b9cS059J/+CIL/SfhGDckO18j
         vUKBsiJHfHzbhNnjP5GedhmDEYVqVNdloYwGyBEAUxs1HCe5WXekkWk/adPF7kijc7TK
         bN3/duva0WtrtsjRijft6xB4S44bSthUrbxco=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695224292; x=1695829092;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KIlfnzN64vt0Db75ZI9wrazd3l6cBizkwl03TscBFBU=;
        b=RYvn6PrcUTEEQfUPNQv0V0ZmoPqPLqfAWfHuw6bNw4jjQ7UuiH3hOBf9aqNE4RkqMv
         lXc0b54t0yd5Y+RkKtk0+vi081jXn/Y8ZOZJ4g9ONzb+lDyNaKdScAjtDTJXpLhTlr89
         kDAfnVPtNg1dtqhxibGjgzbuUvdNj1j+/R5sfbe9qmbugXFecRLunPkO8ZCWfH2Dc9DS
         wSLLTkbCyjri0HwCQOacK/wwkQxS2+ih9vZRquNQImeh7eFQspfcBITGFh8EbyMW5Vp5
         PH0uiyMzONBcyvLe8cU3VDlo3kWNuPeqDhEtsgFBtNLduAB3xfp16qOH3aIitM8AdB1K
         rNXg==
X-Gm-Message-State: AOJu0YxVlgnBwRPlF3aWD16k3oWJGvEXo++Odun/hbIrgkhyfg1gvKxd
        kUbDM3cdw6lM3Gh1s3uyADLdPO8YJ4fG+agGnkk=
X-Google-Smtp-Source: AGHT+IE1DOyr9yY663BmjzKsqSYI/feK+DfQZwVOtqnpy/SKQBvmI6yXpFyHjBuRMaZeq4tzMyk7/A==
X-Received: by 2002:a17:902:9344:b0:1bc:5924:2da2 with SMTP id g4-20020a170902934400b001bc59242da2mr2463874plp.56.1695224292381;
        Wed, 20 Sep 2023 08:38:12 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id c10-20020a170902d48a00b001bc445e249asm8993425plg.124.2023.09.20.08.38.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 08:38:12 -0700 (PDT)
Date:   Wed, 20 Sep 2023 08:38:11 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH v3] null_blk: replace strncpy with strscpy
Message-ID: <202309200837.FAE2C061FB@keescook>
References: <20230919-strncpy-drivers-block-null_blk-main-c-v3-1-10cf0a87a2c3@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230919-strncpy-drivers-block-null_blk-main-c-v3-1-10cf0a87a2c3@google.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Sep 19, 2023 at 05:30:35AM +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings [1].
> 
> We should favor a more robust and less ambiguous interface.
> 
> We expect that both `nullb->disk_name` and `disk->disk_name` be
> NUL-terminated:
> |     snprintf(nullb->disk_name, sizeof(nullb->disk_name),
> |              "%s", config_item_name(&dev->group.cg_item));
> ...
> |       pr_info("disk %s created\n", nullb->disk_name);
> 
> It seems like NUL-padding may be required due to __assign_disk_name()
> utilizing a memcpy as opposed to a `str*cpy` api.
> | static inline void __assign_disk_name(char *name, struct gendisk *disk)
> | {
> | 	if (disk)
> | 		memcpy(name, disk->disk_name, DISK_NAME_LEN);
> | 	else
> | 		memset(name, 0, DISK_NAME_LEN);
> | }
> 
> Then we go and print it with `__print_disk_name` which wraps `nullb_trace_disk_name()`.
> | #define __print_disk_name(name) nullb_trace_disk_name(p, name)
> 
> This function obviously expects a NUL-terminated string.
> | const char *nullb_trace_disk_name(struct trace_seq *p, char *name)
> | {
> | 	const char *ret = trace_seq_buffer_ptr(p);
> |
> | 	if (name && *name)
> | 		trace_seq_printf(p, "disk=%s, ", name);
> | 	trace_seq_putc(p, 0);
> |
> | 	return ret;
> | }
> 
> From the above, we need both 1) a NUL-terminated string and 2) a
> NUL-padded string. So, let's use strscpy_pad() as per Kees' suggestion
> from v1.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: Nathan Chancellor <nathan@kernel.org>
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Thanks for the analysis in the commit log, and yeah, this looks right to
me.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
