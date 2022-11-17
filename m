Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFA4FC4332F
	for <linux-hardening@archiver.kernel.org>; Thu, 17 Nov 2022 00:35:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233825AbiKQAfH (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 16 Nov 2022 19:35:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233204AbiKQAfG (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 16 Nov 2022 19:35:06 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBB0CDE9A
        for <linux-hardening@vger.kernel.org>; Wed, 16 Nov 2022 16:35:05 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id d13-20020a17090a3b0d00b00213519dfe4aso445787pjc.2
        for <linux-hardening@vger.kernel.org>; Wed, 16 Nov 2022 16:35:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tmvJEwiZ21xXLrZBi1WIG/q1ERap31TpLTpBBT5zmxU=;
        b=cakRGVlFP4zUUwjnILOJJPN0XKbQNn0ZanA9TWdtV07Sm+c6Bw6IqGBgu3qize0fev
         s3xAxHQe/+6KbKtzhhRRZngAIPva5ZZ0QfQCpQ4Ky/icC0A10gkkNIo0Yc0hMvcoom1H
         H1hQRpPincosjsYy1r4B9an3mEa3ozSoAZYXI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tmvJEwiZ21xXLrZBi1WIG/q1ERap31TpLTpBBT5zmxU=;
        b=nn7QdUBLgo8/3GtG16ZZfpPHorLCCa4DT7qbCoe31QkEE7H7h7Q7wpX9cnMAlHJKen
         z1rEMdvvlDt2Tgzir5Ei2bPq1d2WKvPP7qvIY6d/3Z6YBjV3siTKWS122i6DdUw4rxxB
         IJQ1isAJ7sz2yVMpX4DF7l5iCS07uwRJsQdClHo1GL4hTm3QZyRABGQdsmjmKcOOoLG/
         LkohFubvxKKAw+lThLBk08htFehXVg3qb/7IrDGP7oDK149WWDUOor9V6IHAGYD/daOH
         mpUDikj/RL1r9oezClv2PF9yzDgvQSg+G+O98g04eTnG3IEudQMcfl+zR9GmonL4zCqM
         spuA==
X-Gm-Message-State: ANoB5pmihnR6dZKoFgXbihYMnTu3a8AmSproAkRwGNsSX+yq0M+K55/I
        6h8lVr9y2wvwSbo/v9zHgj9PfQ==
X-Google-Smtp-Source: AA0mqf7hGFDPMqrXLDMFH04Laqegvn/zp/DoAbfPZEQx8qVyF2TAzljQnVqhbhiC7J0cic+rnY/IhQ==
X-Received: by 2002:a17:902:c085:b0:186:fd58:c700 with SMTP id j5-20020a170902c08500b00186fd58c700mr274156pld.119.1668645305460;
        Wed, 16 Nov 2022 16:35:05 -0800 (PST)
Received: from google.com ([240f:75:7537:3187:d87c:a39a:d965:288])
        by smtp.gmail.com with ESMTPSA id c133-20020a624e8b000000b00572275e68b2sm6980384pfb.116.2022.11.16.16.35.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 16:35:04 -0800 (PST)
Date:   Thu, 17 Nov 2022 09:35:00 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Namjae Jeon <linkinjeon@kernel.org>,
        Steve French <sfrench@samba.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Tom Talpey <tom@talpey.com>, linux-cifs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] ksmbd: replace one-element arrays with
 flexible-array members
Message-ID: <Y3WBtLYcBonVrJio@google.com>
References: <Y3OxronfaPYv9qGP@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3OxronfaPYv9qGP@work>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On (22/11/15 09:35), Gustavo A. R. Silva wrote:
> One-element arrays are deprecated, and we are replacing them with flexible
> array members instead. So, replace one-element arrays with flexible-array
> members in multiple structs in fs/ksmbd/smb_common.h and one in
> fs/ksmbd/smb2pdu.h.
> 
> Important to mention is that doing a build before/after this patch results
> in no binary output differences.
> 
> This helps with the ongoing efforts to tighten the FORTIFY_SOURCE routines
> on memcpy() and help us make progress towards globally enabling
> -fstrict-flex-arrays=3 [1].
> 
> Link: https://github.com/KSPP/linux/issues/242
> Link: https://github.com/KSPP/linux/issues/79
> Link: https://gcc.gnu.org/pipermail/gcc-patches/2022-October/602902.html [1]
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
