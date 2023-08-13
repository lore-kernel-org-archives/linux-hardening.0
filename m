Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB9B1C04A6A
	for <linux-hardening@archiver.kernel.org>; Sun, 13 Aug 2023 12:44:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbjHMMoq (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sun, 13 Aug 2023 08:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjHMMop (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sun, 13 Aug 2023 08:44:45 -0400
Received: from mx.skole.hr (mx1.hosting.skole.hr [161.53.165.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67804E6F;
        Sun, 13 Aug 2023 05:44:44 -0700 (PDT)
Received: from mx1.hosting.skole.hr (localhost.localdomain [127.0.0.1])
        by mx.skole.hr (mx.skole.hr) with ESMTP id 90BC682B08;
        Sun, 13 Aug 2023 14:44:31 +0200 (CEST)
Message-ID: <c98f26a3-1cd7-4e0a-9336-73587c19b158@skole.hr>
Date:   Sun, 13 Aug 2023 14:43:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/8] dt-bindings: clock: Add Marvell PXA1908 clock
 bindings
To:     Conor Dooley <conor@kernel.org>
Cc:     Robert Jarzmik <robert.jarzmik@free.fr>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-hardening@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        afaerber@suse.de
References: <20230812-pxa1908-lkml-v5-0-a5d51937ee34@skole.hr>
 <20230812-pxa1908-lkml-v5-3-a5d51937ee34@skole.hr>
 <20230813-overarch-golf-e467a8adc559@spud>
Content-Language: en-US
From:   =?UTF-8?Q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
In-Reply-To: <20230813-overarch-golf-e467a8adc559@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On 8/13/2023 12:01 PM, Conor Dooley wrote:
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks for the review.

Regards,
Duje

