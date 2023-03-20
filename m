Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C0D4C7618A
	for <linux-hardening@archiver.kernel.org>; Mon, 20 Mar 2023 17:43:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbjCTRnx (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 20 Mar 2023 13:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbjCTRne (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 20 Mar 2023 13:43:34 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D47E19EEF
        for <linux-hardening@vger.kernel.org>; Mon, 20 Mar 2023 10:39:15 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id q23so1624775pfs.2
        for <linux-hardening@vger.kernel.org>; Mon, 20 Mar 2023 10:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1679333953;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Mj8BMtgaqpcJ2izjHoCa3UBL6C1oS24zpeZ0O+klY+Q=;
        b=Z3+VpLz+lOm8RKdKSJ/nRK4OcwRzXaiergdD3dh/LHJwXIL43nZZXSZvvei1uxJrrW
         FKrtsg2XIWSzkx7w5Hte2o0ryKqwv7ugIIeLufW35kLDiwULMkpcynmBfHqmBFbGsA6l
         OCIpwyBBoWAbT93Gxp+UflYk914/xh5zEO180=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679333953;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mj8BMtgaqpcJ2izjHoCa3UBL6C1oS24zpeZ0O+klY+Q=;
        b=iaH/8sH4ukBxYkoCQISnHc+lnFKfEPUxbQGbYcMsU2hhvhMn5KRDAru43aSQVNJau5
         4kkzdpRIk3aEGxxtPjU+6M+54HMfpyElBtdbYTblKnj1V9qMpidEQ5kiYdVJNbWNMZMZ
         OtV5VNbChQt3hfgPLaqLk9iSV87P6QncymhrN9moEo2dlhIXAvYqhieqVhtO/WQLUV88
         lfl7dwWOhQ5tL6RYh/OsvRDNY3xxiVbJMehGcIpLYcdGeeK+VCUf5ZvCeIgyCllWaJHM
         zmS51O28ShLEk6UVaSbW+EFlSHNcMnkl06GTwK+Acfqcp01OOLcCZ5OcbAmphQ9m5ZXW
         kH7g==
X-Gm-Message-State: AO0yUKX2QpCsO8I4wW1JxmzKt/a43qYX5y+7KB4sVwc6j7PJkKqApomG
        HKjv8QSvICZtSsUIx0QcS9NpFw==
X-Google-Smtp-Source: AK7set8IIyRVLx7g0PGp9Q0H2+W3ieCdIjaAbxCxs39Qs/AxGF7FAqBfxjixUjvjyvOasatQ54Y7HQ==
X-Received: by 2002:a62:1881:0:b0:623:dfdd:f7eb with SMTP id 123-20020a621881000000b00623dfddf7ebmr152756pfy.12.1679333952731;
        Mon, 20 Mar 2023 10:39:12 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id b5-20020aa78105000000b005938f5b7231sm6573800pfi.201.2023.03.20.10.39.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 10:39:12 -0700 (PDT)
Message-ID: <64189a40.a70a0220.70bd2.b03b@mx.google.com>
X-Google-Original-Message-ID: <202303201039.@keescook>
Date:   Mon, 20 Mar 2023 10:39:11 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     David Howells <dhowells@redhat.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-afs@lists.infradead.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] rxrpc: Replace fake flex-array with flexible-array
 member
References: <ZAZT11n4q5bBttW0@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZAZT11n4q5bBttW0@work>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, Mar 06, 2023 at 02:57:59PM -0600, Gustavo A. R. Silva wrote:
> Zero-length arrays as fake flexible arrays are deprecated and we are
> moving towards adopting C99 flexible-array members instead.
> 
> Transform zero-length array into flexible-array member in struct
> rxrpc_ackpacket.
> 
> Address the following warnings found with GCC-13 and
> -fstrict-flex-arrays=3 enabled:
> net/rxrpc/call_event.c:149:38: warning: array subscript i is outside array bounds of ‘uint8_t[0]’ {aka ‘unsigned char[]’} [-Warray-bounds=]
> 
> This helps with the ongoing efforts to tighten the FORTIFY_SOURCE
> routines on memcpy() and help us make progress towards globally
> enabling -fstrict-flex-arrays=3 [1].
> 
> Link: https://github.com/KSPP/linux/issues/21
> Link: https://github.com/KSPP/linux/issues/263
> Link: https://gcc.gnu.org/pipermail/gcc-patches/2022-October/602902.html [1]
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
