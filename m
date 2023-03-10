Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56B35C6FD19
	for <linux-hardening@archiver.kernel.org>; Fri, 10 Mar 2023 19:07:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231393AbjCJTHk (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 10 Mar 2023 14:07:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231414AbjCJTHV (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 10 Mar 2023 14:07:21 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A97E1368BE
        for <linux-hardening@vger.kernel.org>; Fri, 10 Mar 2023 11:07:03 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id t129so2423941iof.12
        for <linux-hardening@vger.kernel.org>; Fri, 10 Mar 2023 11:07:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678475223;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eWqtsiqhGUvNVAxgRGNmyViFn5ukJIP+nu+2X15PDag=;
        b=lP+cRiqQYogRnG8ytsvBRJH62sDPxM3+CDXZhL5XklrS+EMZfkeHz6srLEEcNzUSKm
         DQr6N4ghWlycKeo8HTR6udWthHKnHA7p+Ry3Ppb6ljZKee48XYYfD10MMFYqFbKq2GfW
         utJapnTS8BCSAfrd10vVbnnse/BcUYaInkirScHdlhRqAPQvySuKfHHF+hna6jkMbTjg
         6U6WqLvkSxMbIpNEneCVMdD2tkpMgcJW3ntwItTTvy0/L26WDIzhDwqGm6Mc/l8JSwwd
         XUAmsvkJbXHXjO8TP2D8SoCozFxRHUi2hiAfZzIu97sY/JgQCM3B5mqm+d6ANOxJwKix
         +edQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678475223;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eWqtsiqhGUvNVAxgRGNmyViFn5ukJIP+nu+2X15PDag=;
        b=TAEaXpRG2onpQfNYAE0CwVIqxOvk/LZ2KxKP0EWuWg/cEzAoKGxyxWZqwiCiGU/b/f
         u+AlS7klf2jbyS4OuahdPc9t628Jqo4Sx/46nmMAXiTG2YfSJ6i44WNeYRZTIgCITv+v
         UlazMFZHQstjHtTgmzQKaCW5xlzxOJAHFAsTL2K3lc/l1Fpc75JMnBAIU0KYpdeRtAVE
         NQNh/3Aa8VnQKKk7fqdgCiVPGvvLfd709D28SLmhx156+ZjVwdghqXI+ZkN1aghEOnio
         QMT7rhQrTlfwQiSsfaCYyl7vgS5SyNDPGdztMJ9j6Aqf5KRxHeP6A7jyy5I33yN6rIU/
         i0hw==
X-Gm-Message-State: AO0yUKU4Qj72M+gBJG9P9018NSuO86W1hSL3lzu9ysI2019Vp6olmxKf
        9o44LE7oreE3apInKC+eDF6Q3w==
X-Google-Smtp-Source: AK7set98xZN8awZ1NN+vEagnjcoQMPk9okvoD5NJwhGvEkQKUqEiVikUd2YXenveqqScArjHta7Ztw==
X-Received: by 2002:a5d:8482:0:b0:74c:91c7:8794 with SMTP id t2-20020a5d8482000000b0074c91c78794mr4158053iom.21.1678475223076;
        Fri, 10 Mar 2023 11:07:03 -0800 (PST)
Received: from google.com ([2620:15c:183:200:4031:1c3f:5d8e:1b77])
        by smtp.gmail.com with ESMTPSA id j2-20020a5d93c2000000b0074c7e84d0c8sm126473ioo.55.2023.03.10.11.07.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 11:07:02 -0800 (PST)
Date:   Fri, 10 Mar 2023 12:06:58 -0700
From:   Ross Zwisler <zwisler@google.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Ross Zwisler <zwisler@chromium.org>, linux-kernel@vger.kernel.org,
        "Tobin C. Harding" <me@tobin.cc>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Wang <jasowang@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Tycho Andersen <tycho@tycho.pizza>, kvm@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, virtualization@lists.linux-foundation.org,
        linux-trace-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v2 0/6] use canonical ftrace path whenever possible
Message-ID: <20230310190658.GA3723158@google.com>
References: <20230215223350.2658616-1-zwisler@google.com>
 <20230310032921-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230310032921-mutt-send-email-mst@kernel.org>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Mar 10, 2023 at 03:29:49AM -0500, Michael S. Tsirkin wrote:
> On Wed, Feb 15, 2023 at 03:33:44PM -0700, Ross Zwisler wrote:
> > Changes in v2:
> >  * Dropped patches which were pulled into maintainer trees.
> >  * Split BPF patches out into another series targeting bpf-next.
> >  * trace-agent now falls back to debugfs if tracefs isn't present.
> >  * Added Acked-by from mst@redhat.com to series.
> >  * Added a typo fixup for the virtio-trace README.
> > 
> > Steven, assuming there are no objections, would you feel comfortable
> > taking this series through your tree?
> 
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> 
> if you want the virtio patches through my tree after all, let me know.

Yes, please, that would be great.  I'll send out v3 with the few patches that
haven't gotten a response, but I'll drop the virtio patches assuming you've
got them.

Thanks!
