Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3EE4CD37BB
	for <linux-hardening@archiver.kernel.org>; Sat, 16 Sep 2023 14:33:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235345AbjIPOdT (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sat, 16 Sep 2023 10:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233817AbjIPOcx (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sat, 16 Sep 2023 10:32:53 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81639CE9
        for <linux-hardening@vger.kernel.org>; Sat, 16 Sep 2023 07:32:47 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-307d58b3efbso2872423f8f.0
        for <linux-hardening@vger.kernel.org>; Sat, 16 Sep 2023 07:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694874766; x=1695479566; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RuCMRYRUI5pE2pACmrLEmespxY+dxj38Ol7yGsVBHSU=;
        b=PuqGDe6CZBYIFMsaW2bIwkwwRy+umt+pbvUsZgYaxXTsxpY1MY6UcdFcZ32Xbzhh7N
         MPtR9SDdRpoYnQ0CJWuUAl5Zwuu2iXIwQSB45yIEHNI6QN0qkpOWvtr38c5rMBi7UW+1
         kB0Dg/gHWlFRM3RvaEZd3pEYv/vyuwqBb+TTigDXkYC8Dww5Y43o8X7CF8ebSVexZmyU
         6mxVceBfza4WEp8kmD+9IZjzi65t87Cw1Ro47uIq72+4iovstqZ+Oqtk31ztOpUy8PK+
         KNDiPibdXcAckXdAguzGwFnZOMa54ovBINgtgM8kNgG7HoETDk3KvXVCv+iIedCWkTqk
         mXyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694874766; x=1695479566;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RuCMRYRUI5pE2pACmrLEmespxY+dxj38Ol7yGsVBHSU=;
        b=nOSWDSmBKCiyk9Xp3ijxe4g+Gd8GX0kQ4Vmzt+2MbsHLvZst8FDPNwrK9XD0E4DNLl
         /XKMNvX+NW3Cf++Dt04IjqT+ha4FBrJunqW7EIZs4RhOp3KrkDzN8Hfi6NZnqGk7GMBl
         7GUpJYAjS57Pjr0KPMmkIQjS/OeSBJw9IGxGThx4MVueEULkd7QpNjAZpP6iVWNUpK07
         Op9BMCRD5wKw4nFRrlqhJAdqh7ZkQpZ9ja96yq/bf0/Su2dYuU+JO4huT3n99+z+k1+K
         xXy7sXXSHc6Ccjr8hwnkdxrmXFliCiADnRhANpn5fiz3VPdz/Z6KvGbUQSXpdxSOQFdZ
         JT7w==
X-Gm-Message-State: AOJu0Yw8Gjxat8+jTgGMzUgcePKToz7wnlxXfz9Q2ROtVwO80GMd9704
        DFAlWNG90mP7HVmNrEw3ediYmA==
X-Google-Smtp-Source: AGHT+IFo2cGGQRjJb8BtVCZ+zzLXMvuJine6w6l4fG9U93EB+rQqIuIbo58+ykYvKJeUmr2pjBhAfA==
X-Received: by 2002:a05:6000:a1a:b0:31f:facb:e1ba with SMTP id co26-20020a0560000a1a00b0031ffacbe1bamr2807958wrb.70.1694874765714;
        Sat, 16 Sep 2023 07:32:45 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id j15-20020a5d604f000000b0031779a6b451sm7270032wrt.83.2023.09.16.07.32.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Sep 2023 07:32:45 -0700 (PDT)
Date:   Sat, 16 Sep 2023 17:32:42 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Philipp Stanner <pstanner@redhat.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Andy Shevchenko <andy@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Christian Brauner <brauner@kernel.org>,
        David Disseldorp <ddiss@suse.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Siddh Raman Pant <code@siddh.me>,
        Nick Alcock <nick.alcock@oracle.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Zack Rusin <zackr@vmware.com>,
        VMware Graphics Reviewers 
        <linux-graphics-maintainer@vmware.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kexec@lists.infradead.org, linux-hardening@vger.kernel.org,
        David Airlie <airlied@redhat.com>
Subject: Re: [PATCH v2 1/5] string.h: add array-wrappers for (v)memdup_user()
Message-ID: <b219788a-69e6-44cf-a609-91f9640967f5@moroto.mountain>
References: <cover.1694202430.git.pstanner@redhat.com>
 <93001a9f3f101be0f374080090f9c32df73ca773.1694202430.git.pstanner@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93001a9f3f101be0f374080090f9c32df73ca773.1694202430.git.pstanner@redhat.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Sep 08, 2023 at 09:59:40PM +0200, Philipp Stanner wrote:
> +static inline void *memdup_array_user(const void __user *src, size_t n, size_t size)
> +{
> +	size_t nbytes;
> +
> +	if (unlikely(check_mul_overflow(n, size, &nbytes)))
> +		return ERR_PTR(-EOVERFLOW);

No need for an unlikely() because check_mul_overflow() already has one
inside.  I feel like -ENOMEM is more traditional but I doubt anyone/userspace
cares.

> +
> +	return memdup_user(src, nbytes);
> +}

regards,
dan carpenter
