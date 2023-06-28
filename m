Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDE9CEB64D7
	for <linux-hardening@archiver.kernel.org>; Wed, 28 Jun 2023 20:51:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbjF1Uv0 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 28 Jun 2023 16:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231416AbjF1UvW (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 28 Jun 2023 16:51:22 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEA6619B0
        for <linux-hardening@vger.kernel.org>; Wed, 28 Jun 2023 13:51:20 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id 46e09a7af769-6b5f362f4beso90313a34.2
        for <linux-hardening@vger.kernel.org>; Wed, 28 Jun 2023 13:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687985480; x=1690577480;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yP0bXSs2vVbWc7nKFI6QoxCUJ3C1YWOqkj+wTitBDqc=;
        b=Lo2CcrCL9oe8kvhQVqlQS5R+0S7iqR0SsmjOLDWpnDgGi9bm8RKsBzZrOb43c7DA7O
         nxbYkYcJgcZEPxP7sn7Crs5BiYti1hQz+prQ7O/08hw7IXMXrHQ2Hua7jebKEe0fN9Hf
         AtkKlUbxX7bSFjCkyoiVHnmD7EDgVc5dYL0O4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687985480; x=1690577480;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yP0bXSs2vVbWc7nKFI6QoxCUJ3C1YWOqkj+wTitBDqc=;
        b=NWArOb9rcV/XW3wH+QEWVKf774mh+35/y0Y9oxah74LhyAMOo6HaTSbWnhdxTiPCaD
         N7b1bQmEA7ybzWwVuDJmPUffBlfnbxl5GSzxflaIYOv6uwigpUe5her9dcsKEwUfNSM7
         j3UJssXMz9VZDyDUCOJtQa/rc8gOyLtpipPAI/rHrerHVd4+CnXd2N1khtcZD7XTjBPa
         ZMzQAea49nRtoSbzNuzBLpKiqkQ0DRTDlXEZhBVda3z7/V6rK71Qpk30XfJJCqBNPW5o
         ZEsO7MPW4lc1mNwHwCksQpFqan4Q75oHdSJmvKNBqVglssjf2CvZBC5SNVijoqCVdill
         69Fg==
X-Gm-Message-State: AC+VfDy4XozYTXwOscsvrIYNr8AuMq4YL/7I7KQQrnY18R6h9pjdgB+b
        qGo+xFJngXJ5+yq/N7y8LFZgNw==
X-Google-Smtp-Source: ACHHUZ6jhyLKKeHPuPtSXt8ApEyv98ChgMOnNAtkcK9QOfalGkyJAcNmZpDpNOlEntpRLln4pnhyLA==
X-Received: by 2002:a05:6830:613:b0:6b8:19d8:6925 with SMTP id w19-20020a056830061300b006b819d86925mr7542358oti.12.1687985480265;
        Wed, 28 Jun 2023 13:51:20 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 21-20020a17090a019500b00256b67208b1sm10669705pjc.56.2023.06.28.13.51.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 13:51:19 -0700 (PDT)
Date:   Wed, 28 Jun 2023 13:51:19 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     aacraid@microsemi.com, "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH 06/10][next] scsi: aacraid: Use struct_size() helper in
 code related to struct sgmapraw
Message-ID: <202306281351.6572899FE@keescook>
References: <cover.1687974498.git.gustavoars@kernel.org>
 <be2e5ecf1c4410ab419e2290341fbc8a0e2ba963.1687974498.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be2e5ecf1c4410ab419e2290341fbc8a0e2ba963.1687974498.git.gustavoars@kernel.org>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Jun 28, 2023 at 11:56:31AM -0600, Gustavo A. R. Silva wrote:
> Prefer struct_size() over open-coded versions.
> 
> Link: https://github.com/KSPP/linux/issues/160
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
