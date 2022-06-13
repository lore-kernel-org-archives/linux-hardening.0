Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05884C433EF
	for <linux-hardening@archiver.kernel.org>; Mon, 13 Jun 2022 19:01:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243054AbiFMTBE (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 13 Jun 2022 15:01:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244262AbiFMTAv (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 13 Jun 2022 15:00:51 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C52AF95DDF
        for <linux-hardening@vger.kernel.org>; Mon, 13 Jun 2022 09:23:16 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id u18so5517482plb.3
        for <linux-hardening@vger.kernel.org>; Mon, 13 Jun 2022 09:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vSNccuYh4we1yOZG+w2VAnrJv46RwvtWv8Xi0I7VYb0=;
        b=hsvCkORtVgR41TYiOOf4gC1iZVI35VK2BvKJXKprg4/aAOmsmzGh7MmU1Yjzuh2Y0c
         XB9OsDGe3tsFn3sOPkYwpDi0nZOF+K6WXfk997VTmOoZnc+TD2dY/Dj3dThEl0ADESNy
         3WMyta6qO45pNCqVz5kPzq/jVNMIsZxMAvm/Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vSNccuYh4we1yOZG+w2VAnrJv46RwvtWv8Xi0I7VYb0=;
        b=luiFPihSeviPv4blh9ZVWzcFnDCu7zOoYSILs4f3HvL38ndboCiD34Ch0sKtY6elEc
         QoITVqAeeX+cZVdqENIHfx4ZCfEvlNQiQydp1xR+I+Fu4AymWrS/ZW5KAZ2vVbFKczph
         /8AvJ0hPXKo+OHSYWBayIysj0PIExXECbz0mQaYmgdpnQ1aeb7tnM4nFOoqsXrVDHdKp
         g5NhhIiaS1mNsFl1ARpInjaXDCbwGVEWES71P7l/mrp8TUkqCjtkF69ovHlZ/uQfgbEb
         Fyx7Cdnla90k2wzwTRNhID0k3eerzpc9vzXInOk6plI8xjgQCPrdNDN5C573b3x3I+3R
         S68g==
X-Gm-Message-State: AJIora8eDBl/dcQuhgR/qG8+cQROyVkrGw3wYwQhk68Z21U0FQsWfUN/
        CkikjIcy7J/7aGbYaz8fqZMgjA==
X-Google-Smtp-Source: AGRyM1spwIqiyw4Fe0nc/aqfToyDFsVpou2Aqr7S4QqIAWEyupmF0bz7MpA6EN2kR7R7y1cM2El+MQ==
X-Received: by 2002:a17:90b:615:b0:1e6:9c25:81ce with SMTP id gb21-20020a17090b061500b001e69c2581cemr601928pjb.148.1655137396268;
        Mon, 13 Jun 2022 09:23:16 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x8-20020a637c08000000b003fe2062e49esm5677678pgc.73.2022.06.13.09.23.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 09:23:15 -0700 (PDT)
Date:   Mon, 13 Jun 2022 09:23:15 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, Uladzislau Rezki <urezki@gmail.com>,
        Zorro Lang <zlang@redhat.com>, linux-xfs@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH 1/3] usercopy: Handle vm_map_ram() areas
Message-ID: <202206130922.A218C4E3E8@keescook>
References: <20220612213227.3881769-1-willy@infradead.org>
 <20220612213227.3881769-2-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220612213227.3881769-2-willy@infradead.org>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Sun, Jun 12, 2022 at 10:32:25PM +0100, Matthew Wilcox (Oracle) wrote:
> vmalloc does not allocate a vm_struct for vm_map_ram() areas.  That causes
> us to deny usercopies from those areas.  This affects XFS which uses
> vm_map_ram() for its directories.
> 
> Fix this by calling find_vmap_area() instead of find_vm_area().

Thanks for the fixes!

> [...]
> +		/* XXX: We should also abort for free vmap_areas */

What's needed to detect this?

-- 
Kees Cook
