Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61AF3C43334
	for <linux-hardening@archiver.kernel.org>; Tue, 28 Jun 2022 19:45:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbiF1Tpk (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 28 Jun 2022 15:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbiF1TpV (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 28 Jun 2022 15:45:21 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 316AB3CA72
        for <linux-hardening@vger.kernel.org>; Tue, 28 Jun 2022 12:38:48 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 23so13144809pgc.8
        for <linux-hardening@vger.kernel.org>; Tue, 28 Jun 2022 12:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=R/m0Mpk7pVuJiIWprQOno/Hpe4AFomZAEcga9jL9YLA=;
        b=bhe/sbwpuGVDQTIiuE1vanGErx/2iYmd4JWtUJ9ONgGYg9xWkpKeD/AFx7lxB4Z/1q
         3/JOWQm0J40kHqjM7KmdJ7b0ORREudvPV3vR2QpJIMz4VsRhAFBhYmfbwJIClZhJFkcB
         ZTkxA1+uiy/3uB2TDvG90iKHTkB6UafPQXBXntJbSIBHIzWKiZbV96ZGLiEqTn3M1u9H
         A9dSVBsWM5F5qxyN8i2cxi6OmDkJEYnkrbAmHAf943MJEU9kNJq9XPps/0BsMk85UpMA
         +YwkTcMRPEYFzgrThZMpITDuq/jmD8Egxrgf6mJiQ3seAVjN7Wa23b/CUgZB14j4tN9v
         XawQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=R/m0Mpk7pVuJiIWprQOno/Hpe4AFomZAEcga9jL9YLA=;
        b=D8hokMwSmg/ekKwtgVNgjtxdRUC74WN61RhnyBGL4WNpWnvTNXASWSMiu+h93/RCGC
         xGP6ZiWiyNZ/v3GqG6r9h1qVrS60LtxRi5XmCdUZwpGL2bZg6fav1VZ/1jt6vU0Zg7NP
         HXWSs6y6mtvNmHNmkGgek5tshklqC2kcqveULbD/Z7qDSlFocBYk6snXTE31dkPdKSCU
         buNnXo79MWd1HFmliYvFXGlpIB9ODYzRMgRzEMonJA1eYqLW7lrIyu/PPR/jaMfL+GvX
         HBC+olSzkKSeHhDCy81M0BUBjyPVKOahkw8T8mfW84jdiYJtDLDQksUzY5/mtu+eqqFz
         C+mg==
X-Gm-Message-State: AJIora8M8tzJPVfkb9WvPRG1r2IsuNTJ7GSux4ZZkoRWCObE9Slkb0zv
        dScvf2Ttw7QEi+joqszanV9c5w==
X-Google-Smtp-Source: AGRyM1seN+3lufLgwt0RnuEk9fybZPgxUv9NUsBwylD1Xh4AvsqeKC6WmitZPWs5OCP9YsaX9dJAfg==
X-Received: by 2002:aa7:96dd:0:b0:525:8869:df13 with SMTP id h29-20020aa796dd000000b005258869df13mr6354581pfq.14.1656445127638;
        Tue, 28 Jun 2022 12:38:47 -0700 (PDT)
Received: from ?IPV6:2620:10d:c085:21e1::165b? ([2620:10d:c090:400::5:f46f])
        by smtp.gmail.com with ESMTPSA id g4-20020a655944000000b003fe4da67980sm9595041pgu.68.2022.06.28.12.38.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jun 2022 12:38:47 -0700 (PDT)
Message-ID: <37147b0c-4b11-37df-6c4a-ee2dfeb9cbb7@kernel.dk>
Date:   Tue, 28 Jun 2022 13:38:44 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH][next] io_uring: replace zero-length array with
 flexible-array member
Content-Language: en-US
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Pavel Begunkov <asml.silence@gmail.com>
Cc:     io-uring@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <20220628193320.GA52629@embeddedor>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220628193320.GA52629@embeddedor>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On 6/28/22 1:33 PM, Gustavo A. R. Silva wrote:
> There is a regular need in the kernel to provide a way to declare
> having a dynamically sized set of trailing elements in a structure.
> Kernel code should always use ?flexible array members?[1] for these
> cases. The older style of one-element or zero-length arrays should
> no longer be used[2].
> 
> [1] https://en.wikipedia.org/wiki/Flexible_array_member
> [2] https://www.kernel.org/doc/html/v5.16/process/deprecated.html#zero-length-and-one-element-arrays

Thanks for sending this separately. As mentioned out-of-band, we already
have it like this in the io_uring.h header in liburing.

Applied for 5.20.

-- 
Jens Axboe

