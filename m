Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 569D0C001DB
	for <linux-hardening@archiver.kernel.org>; Sun,  2 Jul 2023 08:29:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbjGBI31 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sun, 2 Jul 2023 04:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjGBI30 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sun, 2 Jul 2023 04:29:26 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79B3410EC
        for <linux-hardening@vger.kernel.org>; Sun,  2 Jul 2023 01:29:23 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-9928abc11deso407051866b.1
        for <linux-hardening@vger.kernel.org>; Sun, 02 Jul 2023 01:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688286561; x=1690878561;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w1biNblKgtJgfVRZwDEOvjX/I6fTJ7KpT17Ok3nZx5M=;
        b=uMqJUTA42zzTNobzfwK8XPREa/a9vj3Xfc/7KWipp1cnp/Jg0XeVY+x4k214j2yY2p
         QoGg5zzyWZV0KJSDggJXTP6f6mbFRRUdjqNSf2NxLj7/wA9SRfIAm46ygvQ63r2uEXpX
         fNoQjpgZVebllbu86RL5eRXcyUHR8Qhpzzihk9iDeJafk2zy7kZGgIGhfVity3Cmmwg0
         pLKzBMIuwWp2HAWLosqYLZF9VyQAZld2sBX35Cf/wCq5foc92YcnAyZQjJYvz2dvD+H2
         e3pIDjwRFmrF+Bh5CEoYUtwBR6uYTLkmSgeZBlRZgUB4OyFMScKs8aVTjco9NECFFkB6
         sGog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688286561; x=1690878561;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w1biNblKgtJgfVRZwDEOvjX/I6fTJ7KpT17Ok3nZx5M=;
        b=SZWliZ8JK2c7985rTrGnjU5B0qSNeL5QQo4GePJUlhNygkEcJc2CRiHztTAGeyjJuy
         VC/8AKgEhIM7OXRDWyKtLSMmOwIk4GG5Efe+oLlyoksn3EsMc0A0u9YFuYfNcvs5d4LD
         TVSZMEBqvRZmeD+l/146QubkNdKHOrftXDZu24oCKaf9Bo87qyFMGCIpxtrgdChSQZUG
         5IB6g2M5qRJifFJtGb2YN2IVOryEb0s26CeoyTrRcdiA2KW8FC1Lvkoqr0ievLTiG1yk
         yX6qjI8kq4iZKsdxyw/PfR/N8n9gPNt+skpMj4AD8qX6RODRReiF5u0Qt/vS1nyNVSKK
         LH7A==
X-Gm-Message-State: ABy/qLYwiP4u2QRafP/RzV6S9ii9x4+c5OfuXmbfOIntqq8jtZzdmPpa
        Pl9hnl66gvE+9LzdfNxwoEsKeA==
X-Google-Smtp-Source: APBJJlEq7536nmIYj1sWz/vSWp1KlO2nfy5GE5f1MJ94C2mivpQ6trVaYeegVFmTsikSDWcGy6GDVg==
X-Received: by 2002:a17:906:e48:b0:988:882b:9a3 with SMTP id q8-20020a1709060e4800b00988882b09a3mr5395799eji.36.1688286561035;
        Sun, 02 Jul 2023 01:29:21 -0700 (PDT)
Received: from [192.168.10.214] ([217.169.179.6])
        by smtp.gmail.com with ESMTPSA id s22-20020aa7cb16000000b0051bed498851sm9043073edt.54.2023.07.02.01.29.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Jul 2023 01:29:20 -0700 (PDT)
Message-ID: <29af84dc-7db8-0c43-07b6-eb743cf25e57@linaro.org>
Date:   Sun, 2 Jul 2023 10:29:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v4 00/21] Add Qualcomm Minidump kernel driver related
 support
Content-Language: en-US
To:     Mukesh Ojha <quic_mojha@quicinc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     corbet@lwn.net, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, keescook@chromium.org, tony.luck@intel.com,
        gpiccoli@igalia.com, mathieu.poirier@linaro.org,
        catalin.marinas@arm.com, will@kernel.org, linus.walleij@linaro.org,
        andy.shevchenko@gmail.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        Alex Elder <elder@linaro.org>
References: <1687955688-20809-1-git-send-email-quic_mojha@quicinc.com>
 <2023062814-chance-flounder-f002@gregkh>
 <CAL_JsqLO9yey2-4FcWsaGxijiS6hGL0SH9VoMuiyei-u9=Cv=w@mail.gmail.com>
 <cc30660f-dd72-aade-6346-a93c6ad4b695@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <cc30660f-dd72-aade-6346-a93c6ad4b695@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On 30/06/2023 18:04, Mukesh Ojha wrote:
>>
>>> We don't add layers when they are not needed, and never when there is no
>>> actual user.  If you need the extra "complexity" later, then add it
>>> later when it is needed as who knows when that will ever be.
>>>
>>> Please redo this series based on that, thanks.
>>
>> My bigger issue with this whole series is what would this all look
>> like if every SoC vendor upstreamed their own custom dumping
>> mechanism. That would be a mess. (I have similar opinions on the
>> $soc-vendor hypervisors.)

Mukesh,

LPC CFP is still open. There will be also Android and Kernel Debugging
LPC microconference tracks. Coming with a unified solution could be a
great topic for LPC. Solutions targeting only one user are quite often
frowned upon.

Best regards,
Krzysztof

