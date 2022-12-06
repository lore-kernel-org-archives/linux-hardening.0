Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CCB3C352A1
	for <linux-hardening@archiver.kernel.org>; Tue,  6 Dec 2022 10:38:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234265AbiLFKh7 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 6 Dec 2022 05:37:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233889AbiLFKhx (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 6 Dec 2022 05:37:53 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 365A8DFDC
        for <linux-hardening@vger.kernel.org>; Tue,  6 Dec 2022 02:36:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670323018;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D9WTzI07B2T90FQ6MBF1oIvNELJRpqkR308N9NI9I8E=;
        b=SB99WnPf9f6kGafyfbOktewcGCfDrvcu1b3i+msWfAh+WL2/ZLbSJftHUFpPXrwWlvWiHD
        VQalX8SMAnKeBXwj2I4WB1uDi0i5qjXclc60Vne+orHeg7cGwVbrexfyAdgV/BsFE7EDTP
        WCqgqL0YpDw22/YC62jYIB/P6Hzd8/0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-180--OKESQHSP7yv3xnMOB4hAw-1; Tue, 06 Dec 2022 05:36:57 -0500
X-MC-Unique: -OKESQHSP7yv3xnMOB4hAw-1
Received: by mail-wm1-f69.google.com with SMTP id r67-20020a1c4446000000b003d09b0fbf54so5082901wma.3
        for <linux-hardening@vger.kernel.org>; Tue, 06 Dec 2022 02:36:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D9WTzI07B2T90FQ6MBF1oIvNELJRpqkR308N9NI9I8E=;
        b=poD93g+6Rzh/qZLhq2F+SUgS3vvp9Klm1QKNww1k/tdDdYaiPGAxXZbs2BTRKAR6OB
         Ofx5qFu945a3oqY3nUIPeY/TN/NqFG/aFwBpay+7fuX+TQbDcY+mETCHoZ2Agk6a+DIk
         Q1WjfWvRTudRdDGR352RMDx/4x8WEDfY3UIE1VjtYeZmg3Kyo2Wm6DRWGqyrWI5rRis9
         6NocjtNe8TWKtJchcyfj9CFV0Zp+miZdGsvMSynHqk5oT0cbVY8+t2Z11eJrI7tGNXHw
         d3o0j6Y51Oyckd6qXMyZNILIbL6XkidYzOYuyehpkI7UvybN+WX1wmNOf8cgkEq5ek+I
         TVaQ==
X-Gm-Message-State: ANoB5pm8EFAqZlIGIYRa944CYeZiXXVQaWlovUMpL+ttiahOQNlKI0QH
        DmheFTl8h8F4xatfk4AJ2xMYR0AhzO77c+jHqW5+HA0r/9CnFjE5kV2Oo4BCYzJ2WQ03VnAW1b7
        1cNjSzS9BPBCMgFyhujgTqx57Nv5K
X-Received: by 2002:a5d:6101:0:b0:242:46d0:3ee1 with SMTP id v1-20020a5d6101000000b0024246d03ee1mr10075197wrt.315.1670323015968;
        Tue, 06 Dec 2022 02:36:55 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4hdCTFiVaTLif2boeNw/kxGbQScPuaS1un/J2RGjn40Favi8QTQ0cVDhBrer5EXpUMnibKEw==
X-Received: by 2002:a5d:6101:0:b0:242:46d0:3ee1 with SMTP id v1-20020a5d6101000000b0024246d03ee1mr10075190wrt.315.1670323015747;
        Tue, 06 Dec 2022 02:36:55 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-106-100.dyn.eolo.it. [146.241.106.100])
        by smtp.gmail.com with ESMTPSA id v128-20020a1cac86000000b003cfa80443a0sm20734164wme.35.2022.12.06.02.36.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 02:36:55 -0800 (PST)
Message-ID: <abd1a8e98d8b6d19520ae41d164ee905a40b3c42.camel@redhat.com>
Subject: Re: [PATCH] net/ncsi: Silence runtime memcpy() false positive
 warning
From:   Paolo Abeni <pabeni@redhat.com>
To:     Kees Cook <keescook@chromium.org>,
        Samuel Mendoza-Jonas <sam@mendozajonas.com>
Cc:     Joel Stanley <joel@jms.id.au>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Date:   Tue, 06 Dec 2022 11:36:54 +0100
In-Reply-To: <20221202212418.never.837-kees@kernel.org>
References: <20221202212418.never.837-kees@kernel.org>
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Hello,

On Fri, 2022-12-02 at 13:24 -0800, Kees Cook wrote:
> The memcpy() in ncsi_cmd_handler_oem deserializes nca->data into a
> flexible array structure that overlapping with non-flex-array members
> (mfr_id) intentionally. Since the mem_to_flex() API is not finished,
> temporarily silence this warning, since it is a false positive, using
> unsafe_memcpy().
> 
> Reported-by: Joel Stanley <joel@jms.id.au>
> Link: https://lore.kernel.org/netdev/CACPK8Xdfi=OJKP0x0D1w87fQeFZ4A2DP2qzGCRcuVbpU-9=4sQ@mail.gmail.com/
> Cc: Samuel Mendoza-Jonas <sam@mendozajonas.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: netdev@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Is this for the -net or the -net-next tree? It applies to both...

It you are targetting the -net tree, I think it would be nicer adding a
suitable Fixes tag.

Thanks!

Paolo

