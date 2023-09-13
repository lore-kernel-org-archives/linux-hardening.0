Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED0DAEE020F
	for <linux-hardening@archiver.kernel.org>; Wed, 13 Sep 2023 22:07:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232969AbjIMWHc (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 13 Sep 2023 18:07:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232758AbjIMWHb (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 13 Sep 2023 18:07:31 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77C4D173A
        for <linux-hardening@vger.kernel.org>; Wed, 13 Sep 2023 15:07:27 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1c3887039d4so2329125ad.1
        for <linux-hardening@vger.kernel.org>; Wed, 13 Sep 2023 15:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694642847; x=1695247647; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fxDfuaaCOGIkY/J7UCucAcZfBxGD0O7N2E+zpPv/A2A=;
        b=jOHPy3ruaBE5qFzc9ldCHn0VON770hgjGuV8uGeSixVmPSAAx6XwxyvPZ6c8qvm/li
         bsB48BIioFGP5F4W67eldUtaIPc/fYEZADn/8YFBtFgXdVm9AD1W0A7JzBf+choJwFzj
         w9/fi9bS8xWE9HoMFdwluFoKdGgTUC5vDOT8A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694642847; x=1695247647;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fxDfuaaCOGIkY/J7UCucAcZfBxGD0O7N2E+zpPv/A2A=;
        b=qh4PC/refIQIdoYgTGfvL6zvdaEMX1W5vVn1bdI/gWc14VINR2RaYGgSxpCDinJ0g7
         rX5cmlTu8uCe4rLr/HhAnVm6/emCk+YlcFZb3quN8zgFUSICFF5QX5QllUN8AVBrXXMD
         NaOGbm8wIWhc6YN0OuoWvDzsR3aCPgz0UiNoKCrWX+KiNnTfR5X8GR8PjmjptQHtbF6j
         ytI2c3A9qCnNwRiy9Sv3+5i4HH6uA78zH6zrlL5Y6LEkttKLOA3gU0LWL2kz+hWa9bRC
         pTWposdzG5pvZ8WWaFuB2SfeuMs7gWUCBJlqTbOW5JE+9NYIyzpSgLCdBVNExOT6WpSO
         p6iQ==
X-Gm-Message-State: AOJu0YzWqaO7YsBlf7jHSyoickFs8SLa58Kz/HGnZcpBM+BstcaaH14U
        c6IWCAbwQ7hTkYoE81xFLrbkMA==
X-Google-Smtp-Source: AGHT+IHxaT5/+ccui2vnFiQVAeKtjd2URt+LuOsqD0F5iWtHIS5/zUtL5g0V6xehNx6RA+H3QM0vDQ==
X-Received: by 2002:a17:902:ecca:b0:1c4:62a:e4a with SMTP id a10-20020a170902ecca00b001c4062a0e4amr576300plh.64.1694642846953;
        Wed, 13 Sep 2023 15:07:26 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id a9-20020a170902ee8900b001bf095dfb76sm97776pld.237.2023.09.13.15.07.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 15:07:26 -0700 (PDT)
Date:   Wed, 13 Sep 2023 15:07:25 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Tejun Heo <tj@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-hardening@vger.kernel.org,
        cgroups@vger.kernel.org
Subject: Re: [PATCH 08/19] pstore: shrink the pstore_sb_lock critical section
 in pstore_kill_sb
Message-ID: <202309131507.E20F3AA130@keescook>
References: <20230913111013.77623-1-hch@lst.de>
 <20230913111013.77623-9-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230913111013.77623-9-hch@lst.de>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Sep 13, 2023 at 08:10:02AM -0300, Christoph Hellwig wrote:
> ->kill_sb can't race with creating ->fill_super because pstore is a
> _single file system that only ever has a single sb instance, and we wait
> for the previous one to go away before creating a new one.  Reduce
> the critical section so that is is not held over generic_shutdown_super.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Thanks for the refactoring!

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
