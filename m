Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C05FEC433EF
	for <linux-hardening@archiver.kernel.org>; Wed, 20 Apr 2022 23:04:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383050AbiDTXGu (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 20 Apr 2022 19:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377225AbiDTXGt (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 20 Apr 2022 19:06:49 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7BAE1EAF3
        for <linux-hardening@vger.kernel.org>; Wed, 20 Apr 2022 16:04:01 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id d23-20020a17090a115700b001d2bde6c234so4327587pje.1
        for <linux-hardening@vger.kernel.org>; Wed, 20 Apr 2022 16:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iskMN1l8MoJsVLKb/tR5RqLTdjqV96Epo8o46Hl8L3Q=;
        b=jR4GgNTqrzZbSJz2PEKhD0EzgZW1lPN/LYzCX9SJe2w/eUpq2KAJLv/eBWwX+Il8hN
         w6gdmz4C/bakoJGpyCj3MqKYQsWXweonbOahCr9Vlk+faVot+srOZUjISELuWEnWgK3E
         5w5Tlf+x3k5xwkogDouSMCIyicqhQRfPtER1o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iskMN1l8MoJsVLKb/tR5RqLTdjqV96Epo8o46Hl8L3Q=;
        b=Ru3Rpm5YCiau1Mf6iihH5uBnr5ZQLS3UncofUDbvPOjhHoe38Re2GIHeL5MHIDyHVn
         InmORi2JhwUigCPXiU+aE7e3vk7/I4NS8dzK99K5bAROv2mAm077OvPn9WhUeNEg/uDS
         pUjroBffSIQ11+TmzOtbPXdfnXid8jCmMUuKhvX3ZLNwt7bNZF5Llt0iJ+KsSr3udytC
         YZFx+KUiTwX4GsxwuY39XQ2QHKL54H+B2nwwhG4A4WUwsIBI2bAr0BIg0Q3yvJPEjTAQ
         W8VRF83LwIG5ppGY76EdvQfPnu3e1sE85x5PlCiUDJyUHbuLNk4maKafLdzFNaq8raaO
         SLYg==
X-Gm-Message-State: AOAM533rB9qNAtYGGXoPKl2Dx+RqK414KuumTa5Db5M+X6xAbRVQDyKh
        p54ep38/l3jfx4o3GvAF6Vj2eQ==
X-Google-Smtp-Source: ABdhPJzKaJN8JZfBosvPW28423daqc6l6+bMNX8syAvTCgjSRwsi1KCnvz5G+bgHHL089kLo97RTfw==
X-Received: by 2002:a17:90b:4f48:b0:1d2:d1fa:4dbd with SMTP id pj8-20020a17090b4f4800b001d2d1fa4dbdmr6906367pjb.246.1650495841437;
        Wed, 20 Apr 2022 16:04:01 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e13-20020a63370d000000b003810782e0cdsm20993213pga.56.2022.04.20.16.04.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 16:04:00 -0700 (PDT)
Date:   Wed, 20 Apr 2022 16:04:00 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Joao Moreira <joao@overdrivepizza.com>
Cc:     linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        peterz@infradead.org, jpoimboe@redhat.com,
        andrew.cooper3@citrix.com, samitolvanen@google.com,
        mark.rutland@arm.com, hjl.tools@gmail.com,
        alyssa.milburn@linux.intel.com, ndesaulniers@google.com,
        gabriel.gomes@linux.intel.com, rick.p.edgecombe@intel.com
Subject: Re: [RFC PATCH 11/11] driver/int3400_thermal: Fix prototype matching
Message-ID: <202204201601.8291F550@keescook>
References: <20220420004241.2093-1-joao@overdrivepizza.com>
 <20220420004241.2093-12-joao@overdrivepizza.com>
 <202204191946.2843CF71@keescook>
 <06435f0b44681588052d145a17d60316@overdrivepizza.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06435f0b44681588052d145a17d60316@overdrivepizza.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Apr 20, 2022 at 03:28:20PM -0700, Joao Moreira wrote:
> > Where/why is the mismatch happening?
> 
> Mismatch happens in dev_attr_show from drivers/base/core.c. There, kobject *
> is cast to device * before the call, probably because attr is also cast to
> device_attribute, which may have a mismatching hook prototype, I guess.

Ah-ha, thanks. I think this will fix it, but I haven't tested it:

diff --git a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
index 4954800b9850..d97f496bab9b 100644
--- a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
+++ b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
@@ -68,7 +68,7 @@ static int evaluate_odvp(struct int3400_thermal_priv *priv);
 struct odvp_attr {
 	int odvp;
 	struct int3400_thermal_priv *priv;
-	struct kobj_attribute attr;
+	struct device_attribute attr;
 };
 
 static ssize_t data_vault_read(struct file *file, struct kobject *kobj,
@@ -311,7 +311,7 @@ static int int3400_thermal_get_uuids(struct int3400_thermal_priv *priv)
 	return result;
 }
 
-static ssize_t odvp_show(struct kobject *kobj, struct kobj_attribute *attr,
+static ssize_t odvp_show(struct device *dev, struct device_attribute *attr,
 			 char *buf)
 {
 	struct odvp_attr *odvp_attr;


-- 
Kees Cook
