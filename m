Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 736FCC38142
	for <linux-hardening@archiver.kernel.org>; Tue, 31 Jan 2023 18:06:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbjAaSGh (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 31 Jan 2023 13:06:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231576AbjAaSGg (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 31 Jan 2023 13:06:36 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 081024204
        for <linux-hardening@vger.kernel.org>; Tue, 31 Jan 2023 10:06:35 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id m16-20020a05600c3b1000b003dc4050c94aso8463753wms.4
        for <linux-hardening@vger.kernel.org>; Tue, 31 Jan 2023 10:06:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qh+BttHshTvqwVfMkHR/OJvGZDmWyNUQNSwogcN12jI=;
        b=iHKBxNV+ta9uv97C6OR1AKGkARIXP8jzYYDNtobOQo58BIfJ7D0pZ/G29kPMKXXKyY
         TyIIh6jr+G00O42SlppKSBMuCD0b4RQzmHhBzRpKsx7eoOvRdcElZu42kyGr8bVvhKse
         xxETzx89nrhf5rKWogWmljTQ9pNBaSorebDwm4k4N4s6WkaZomppS182PStPSMXQT6d2
         5nfJooRJ3gYGmPoIXl+rOvsDK6W5Ys22gLupIDhsBLpFSKbgt27FZba6SnG5lmQYYnHy
         6MgMTIh2qCzp8TFF0yNZj62WyrZrp6eYLr7+agac9rIsfOeaCIQgbaGnvL3HkO2qeNMc
         1qjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qh+BttHshTvqwVfMkHR/OJvGZDmWyNUQNSwogcN12jI=;
        b=WvMnRVsgvFbpXlidpQMBnm7bdD/vcO1JriL7MJRcTguQi+3gF/vx/nY2uuLHFVFfAd
         LFahbXG5ZW5cWf4mNc/RESBbUcjhufYoOEwO0gZHw5IpNtnIbfje17N2msPOsASq3Ewf
         sHPtbB3HoORNtaB334n8tFPUOJcQCvCYjJc9u4q2mWiE9UssS9d3aNhP2oAtlpJlJljc
         abZOsP8zAyRy3z2BBewISPVLvuTJ8U+hU16vaCO9eduqSTKHLVqGUinPXAICW/UWhl78
         3fUIdS1Zf+Fe45Ew+bsNWQCIOXhKw+077Scxa26apy1MqhJZNpPzt4hvz43TRLP8bS20
         kqNg==
X-Gm-Message-State: AO0yUKXD+6CnP40eAVAX+7UhxoIcfpEOlBVxqn6y66An2SccWOA0Z4Ts
        2uofze7ZzWd0C5brJGPr4CscAA==
X-Google-Smtp-Source: AK7set+U0oWmsLzOC6Wyg2iH/NpVV8Td/9IjuerrNEU8eAfO3O1xFO2g9XLO9KPaJo27WpX+EyH3Lg==
X-Received: by 2002:a1c:4c19:0:b0:3dc:5342:9f53 with SMTP id z25-20020a1c4c19000000b003dc53429f53mr11821146wmf.38.1675188393663;
        Tue, 31 Jan 2023 10:06:33 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id n10-20020a05600c180a00b003daf672a616sm16145460wmp.22.2023.01.31.10.06.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Jan 2023 10:06:33 -0800 (PST)
Message-ID: <ecfd20e4-905a-3ce3-86af-c9d9ad0cfd94@linaro.org>
Date:   Tue, 31 Jan 2023 19:06:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v4 1/2] dt-bindings: arm: qcom: Add Xiaomi Mi Pad 5 Pro
 (xiaomi-elish)
Content-Language: en-US
To:     Jianhua Lu <lujianhua000@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G . Piccoli" <gpiccoli@igalia.com>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
References: <20230131123515.833-1-lujianhua000@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230131123515.833-1-lujianhua000@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On 31/01/2023 13:35, Jianhua Lu wrote:
> Add a compatible for Xiaomi Mi Pad 5 Pro.
> 
> Signed-off-by: Jianhua Lu <lujianhua000@gmail.com>
> ---
> No changes in v4
> 
> Changes in v3:
>   - Pick up Krzysztof's A-b

Where is it?

Best regards,
Krzysztof

