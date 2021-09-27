Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AE1AC433F5
	for <linux-hardening@archiver.kernel.org>; Mon, 27 Sep 2021 15:10:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E7A1604D1
	for <linux-hardening@archiver.kernel.org>; Mon, 27 Sep 2021 15:10:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234989AbhI0PMI (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 27 Sep 2021 11:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235002AbhI0PMH (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 27 Sep 2021 11:12:07 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5DE8C061575;
        Mon, 27 Sep 2021 08:10:29 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id x27so79016779lfu.5;
        Mon, 27 Sep 2021 08:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=rsN9K+kBj4WsaMVc7d6EJNER4Dghf2g4/H1pk5HbiU4=;
        b=DgAXLH1x8oeMgZwezwh55xyysdxd2V/dbgQ11GURkrtvnlmNiSC2nAvOlg035EVbFH
         XTsY/YnEd0Oq1heaggr/CKcAIn63RNxvFVpaJM8t7LoNpwJ1WMkTAJ+tp1KaW1RV+nd4
         tLn3PnQRJzsJLYUHzCtKKcidMYFjfElrb8mmkydYazitQVTocVP4jgSlUHmKNNiDkW37
         QVB15O5Ro6P8pPQdVMN8rPLatqw5qz/+11xrJB4zxowQuAiSxCvV8Udw7mSVSgAJZqMN
         KFsbl30kYCqDbVFOzRP+6I2vrC7KrntXB9WvSKhOMMTdUHsNb+fYt3e3kZ4K8hgY8G6v
         8trg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rsN9K+kBj4WsaMVc7d6EJNER4Dghf2g4/H1pk5HbiU4=;
        b=72+Xs70iRPIkA7cqgbnkhs1VuhQcG7Fhqvtz5RcZmsaCB0RSVbl2/Ixo7IvDnV8Bf2
         DSxvam6CU47rb4z6JsPI0Sw7MXnuC7h7acfoRxiZqcLA1OsGKejXpJvUevFuOttdhCR1
         m9bowvzp+zOndNNlfTEUDTrk3QBMnK9wy4x9/FSRf/pncYrF9f6OhILfFJDbbV4ifpKg
         vWqJm4QVT2EZPWuyDsvzOn38WsxKXqndxiF7VRLIoam6ZywiE8dCWLRNWgHrXukzYDWG
         e8TlJ+P2RuOxHMBQ36d4vx01/q5euY3Z9FTHg0jDSCK4oYdGmj7e/0EIX+9TZ0Vy1S2U
         Z2Wg==
X-Gm-Message-State: AOAM5318fGpIu6sjJU29zgJ/aSnQlajvPQz6KtaX3y+nvKcGrkiUpdF8
        6nXfjz+9oelapsUFlmpdtU8TDS4WVb4=
X-Google-Smtp-Source: ABdhPJyIIozG0ymxObNaO/4YC1alvEpRaqdmAx/CO9DSCeZcsS6XwJXhY34v11F3Sr3JH9OKr11IkQ==
X-Received: by 2002:a05:6512:39ca:: with SMTP id k10mr352790lfu.54.1632755427741;
        Mon, 27 Sep 2021 08:10:27 -0700 (PDT)
Received: from [192.168.2.145] (46-138-80-108.dynamic.spd-mgts.ru. [46.138.80.108])
        by smtp.googlemail.com with ESMTPSA id v1sm1629381lfp.215.2021.09.27.08.10.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Sep 2021 08:10:27 -0700 (PDT)
Subject: Re: [PATCH] scripts/gcc-plugins: consistently use HOSTCC
To:     Kees Cook <keescook@chromium.org>,
        Ross Burton <ross.burton@arm.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20210923152811.406516-1-ross.burton@arm.com>
 <163243252379.3933826.2645114887075876479.b4-ty@chromium.org>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <d2b6c3d1-45a6-5820-cedf-28390ffcc8cd@gmail.com>
Date:   Mon, 27 Sep 2021 18:10:26 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <163243252379.3933826.2645114887075876479.b4-ty@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

MjQuMDkuMjAyMSAwMDoyOCwgS2VlcyBDb29rINC/0LjRiNC10YI6DQo+IE9uIFRodSwgMjMg
U2VwIDIwMjEgMTY6Mjg6MTEgKzAxMDAsIFJvc3MgQnVydG9uIHdyb3RlOg0KPj4gVGhlIEdD
QyBwbHVnaW5zIGFyZSBidWlsdCB1c2luZyBIT1NUQ0MsIGJ1dCB0aGUgcGF0aCB0byB0aGUg
R0NDIHBsdWdpbnMNCj4+IGhlYWRlcnMgaXMgb2J0YWluZWQgdXNpbmcgQ0MuICBUaGlzIGNh
biBsZWFkIHRvIGludGVyZXN0aW5nIGZhaWx1cmVzIGlmDQo+PiB0aGUgaG9zdCBjb21waWxl
ciBhbmQgY3Jvc3MgY29tcGlsZXIgYXJlIGRpZmZlcmVudCB2ZXJzaW9ucywgYW5kIHRoZQ0K
Pj4gaG9zdCBjb21waWxlciB1c2VzIHRoZSBjcm9zcyBoZWFkZXJzLg0KPiANCj4gKEkgY2hh
bmdlZCB0aGlzIGZyb20gSE9TVENDIHRvIEhPU1RDWFggdG8gbWF0Y2ggdGhlIG90aGVyIGlu
dm9jYXRpb25zLikNCj4gDQo+IEFwcGxpZWQgdG8gZm9yLW5leHQvZ2NjLXBsdWdpbnMsIHRo
YW5rcyENCj4gDQo+IFsxLzFdIHNjcmlwdHMvZ2NjLXBsdWdpbnM6IGNvbnNpc3RlbnRseSB1
c2UgSE9TVENDDQo+ICAgICAgIGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcva2Vlcy9jL2VmNWVj
YjEyOTc5MQ0KPiANCg0KSSdtIGdldHRpbmcgdGhlc2UgZXJyb3JzIHdoZW4gY29tcGlsaW5n
IEFSTTMyIGtlcm5lbCB1c2luZyB0b2RheSdzIC1uZXh0Og0KDQpjYzE6IGVycm9yOiBpbmNv
bXBhdGlibGUgZ2NjL3BsdWdpbiB2ZXJzaW9ucw0KY2MxOiBlcnJvcjogZmFpbGVkIHRvIGlu
aXRpYWxpemUgcGx1Z2luIC4vc2NyaXB0cy9nY2MtcGx1Z2lucy9hcm1fc3NwX3Blcl90YXNr
X3BsdWdpbi5zbw0KDQpCb3RoIGhvc3QgYW5kIGNyb3NzIGNvbXBpbGVyIGFyZSB0aGUgc2Ft
ZSB2ZXJzaW9uOg0KDQojIGdjYy1jb25maWcgLWwNCiBbMV0gYXJtdjdhLWhhcmRmbG9hdC1s
aW51eC1nbnVlYWJpLTkuMy4wDQogWzJdIGFybXY3YS1oYXJkZmxvYXQtbGludXgtZ251ZWFi
aS0xMC4zLjANCiBbM10gYXJtdjdhLWhhcmRmbG9hdC1saW51eC1nbnVlYWJpLTExLjEuMCAq
DQoNCiBbNF0geDg2XzY0LXBjLWxpbnV4LWdudS0xMS4xLjAgKg0KDQojIGdjYyAtdg0K0JjR
gdC/0L7Qu9GM0LfRg9GO0YLRgdGPINCy0L3Rg9GC0YDQtdC90L3QuNC1INGB0L/QtdGG0LjR
hNC40LrQsNGG0LjQuC4NCkNPTExFQ1RfR0NDPWdjYw0KQ09MTEVDVF9MVE9fV1JBUFBFUj0v
dXNyL2xpYmV4ZWMvZ2NjL3g4Nl82NC1wYy1saW51eC1nbnUvMTEuMS4wL2x0by13cmFwcGVy
DQrQptC10LvQtdCy0LDRjyDQsNGA0YXQuNGC0LXQutGC0YPRgNCwOiB4ODZfNjQtcGMtbGlu
dXgtZ251DQrQn9Cw0YDQsNC80LXRgtGA0Ysg0LrQvtC90YTQuNCz0YPRgNCw0YbQuNC4OiAv
dmFyL3RtcC9wb3J0YWdlL3N5cy1kZXZlbC9nY2MtMTEuMS4wLXIyL3dvcmsvZ2NjLTExLjEu
MC9jb25maWd1cmUgLS1ob3N0PXg4Nl82NC1wYy1saW51eC1nbnUgLS1idWlsZD14ODZfNjQt
cGMtbGludXgtZ251IC0tcHJlZml4PS91c3IgLS1iaW5kaXI9L3Vzci94ODZfNjQtcGMtbGlu
dXgtZ251L2djYy1iaW4vMTEuMS4wIC0taW5jbHVkZWRpcj0vdXNyL2xpYi9nY2MveDg2XzY0
LXBjLWxpbnV4LWdudS8xMS4xLjAvaW5jbHVkZSAtLWRhdGFkaXI9L3Vzci9zaGFyZS9nY2Mt
ZGF0YS94ODZfNjQtcGMtbGludXgtZ251LzExLjEuMCAtLW1hbmRpcj0vdXNyL3NoYXJlL2dj
Yy1kYXRhL3g4Nl82NC1wYy1saW51eC1nbnUvMTEuMS4wL21hbiAtLWluZm9kaXI9L3Vzci9z
aGFyZS9nY2MtZGF0YS94ODZfNjQtcGMtbGludXgtZ251LzExLjEuMC9pbmZvIC0td2l0aC1n
eHgtaW5jbHVkZS1kaXI9L3Vzci9saWIvZ2NjL3g4Nl82NC1wYy1saW51eC1nbnUvMTEuMS4w
L2luY2x1ZGUvZysrLXYxMSAtLXdpdGgtcHl0aG9uLWRpcj0vc2hhcmUvZ2NjLWRhdGEveDg2
XzY0LXBjLWxpbnV4LWdudS8xMS4xLjAvcHl0aG9uIC0tZW5hYmxlLWxhbmd1YWdlcz1jLGMr
Kyxmb3J0cmFuIC0tZW5hYmxlLW9ic29sZXRlIC0tZW5hYmxlLXNlY3VyZXBsdCAtLWRpc2Fi
bGUtd2Vycm9yIC0td2l0aC1zeXN0ZW0temxpYiAtLWVuYWJsZS1ubHMgLS13aXRob3V0LWlu
Y2x1ZGVkLWdldHRleHQgLS1kaXNhYmxlLWxpYnVud2luZC1leGNlcHRpb25zIC0tZW5hYmxl
LWNoZWNraW5nPXJlbGVhc2UgLS13aXRoLWJ1Z3VybD1odHRwczovL2J1Z3MuZ2VudG9vLm9y
Zy8gLS13aXRoLXBrZ3ZlcnNpb249J0dlbnRvbyAxMS4xLjAtcjIgcDMnIC0tZGlzYWJsZS1l
c3AgLS1lbmFibGUtbGlic3RkY3h4LXRpbWUgLS1lbmFibGUtc2hhcmVkIC0tZW5hYmxlLXRo
cmVhZHM9cG9zaXggLS1lbmFibGUtX19jeGFfYXRleGl0IC0tZW5hYmxlLWNsb2NhbGU9Z251
IC0tZW5hYmxlLW11bHRpbGliIC0td2l0aC1tdWx0aWxpYi1saXN0PW0zMixtNjQgLS1kaXNh
YmxlLWZpeGVkLXBvaW50IC0tZW5hYmxlLXRhcmdldHM9YWxsIC0tZW5hYmxlLWxpYmdvbXAg
LS1kaXNhYmxlLWxpYnNzcCAtLWRpc2FibGUtbGliYWRhIC0tZGlzYWJsZS1zeXN0ZW10YXAg
LS1kaXNhYmxlLXZhbGdyaW5kLWFubm90YXRpb25zIC0tZGlzYWJsZS12dGFibGUtdmVyaWZ5
IC0tZGlzYWJsZS1saWJ2dHYgLS13aXRob3V0LXpzdGQgLS1lbmFibGUtbHRvIC0td2l0aC1p
c2wgLS1kaXNhYmxlLWlzbC12ZXJzaW9uLWNoZWNrIC0tZW5hYmxlLWRlZmF1bHQtcGllIC0t
ZW5hYmxlLWRlZmF1bHQtc3NwDQrQnNC+0LTQtdC70Ywg0LzQvdC+0LPQvtC/0L7RgtC+0YfQ
vdC+0YHRgtC4OiBwb3NpeA0KU3VwcG9ydGVkIExUTyBjb21wcmVzc2lvbiBhbGdvcml0aG1z
OiB6bGliDQpnY2Mg0LLQtdGA0YHQuNGPIDExLjEuMCAoR2VudG9vIDExLjEuMC1yMiBwMykN
Cg0KIyBhcm12N2EtaGFyZGZsb2F0LWxpbnV4LWdudWVhYmktZ2NjIC12DQrQmNGB0L/QvtC7
0YzQt9GD0Y7RgtGB0Y8g0LLQvdGD0YLRgNC10L3QvdC40LUg0YHQv9C10YbQuNGE0LjQutCw
0YbQuNC4Lg0KQ09MTEVDVF9HQ0M9YXJtdjdhLWhhcmRmbG9hdC1saW51eC1nbnVlYWJpLWdj
Yw0KQ09MTEVDVF9MVE9fV1JBUFBFUj0vdXNyL2xpYmV4ZWMvZ2NjL2FybXY3YS1oYXJkZmxv
YXQtbGludXgtZ251ZWFiaS8xMS4xLjAvbHRvLXdyYXBwZXINCtCm0LXQu9C10LLQsNGPINCw
0YDRhdC40YLQtdC60YLRg9GA0LA6IGFybXY3YS1oYXJkZmxvYXQtbGludXgtZ251ZWFiaQ0K
0J/QsNGA0LDQvNC10YLRgNGLINC60L7QvdGE0LjQs9GD0YDQsNGG0LjQuDogL3Zhci90bXAv
cG9ydGFnZS9jcm9zcy1hcm12N2EtaGFyZGZsb2F0LWxpbnV4LWdudWVhYmkvZ2NjLTExLjEu
MC1yMi93b3JrL2djYy0xMS4xLjAvY29uZmlndXJlIC0taG9zdD14ODZfNjQtcGMtbGludXgt
Z251IC0tdGFyZ2V0PWFybXY3YS1oYXJkZmxvYXQtbGludXgtZ251ZWFiaSAtLWJ1aWxkPXg4
Nl82NC1wYy1saW51eC1nbnUgLS1wcmVmaXg9L3VzciAtLWJpbmRpcj0vdXNyL3g4Nl82NC1w
Yy1saW51eC1nbnUvYXJtdjdhLWhhcmRmbG9hdC1saW51eC1nbnVlYWJpL2djYy1iaW4vMTEu
MS4wIC0taW5jbHVkZWRpcj0vdXNyL2xpYi9nY2MvYXJtdjdhLWhhcmRmbG9hdC1saW51eC1n
bnVlYWJpLzExLjEuMC9pbmNsdWRlIC0tZGF0YWRpcj0vdXNyL3NoYXJlL2djYy1kYXRhL2Fy
bXY3YS1oYXJkZmxvYXQtbGludXgtZ251ZWFiaS8xMS4xLjAgLS1tYW5kaXI9L3Vzci9zaGFy
ZS9nY2MtZGF0YS9hcm12N2EtaGFyZGZsb2F0LWxpbnV4LWdudWVhYmkvMTEuMS4wL21hbiAt
LWluZm9kaXI9L3Vzci9zaGFyZS9nY2MtZGF0YS9hcm12N2EtaGFyZGZsb2F0LWxpbnV4LWdu
dWVhYmkvMTEuMS4wL2luZm8gLS13aXRoLWd4eC1pbmNsdWRlLWRpcj0vdXNyL2xpYi9nY2Mv
YXJtdjdhLWhhcmRmbG9hdC1saW51eC1nbnVlYWJpLzExLjEuMC9pbmNsdWRlL2crKy12MTEg
LS13aXRoLXB5dGhvbi1kaXI9L3NoYXJlL2djYy1kYXRhL2FybXY3YS1oYXJkZmxvYXQtbGlu
dXgtZ251ZWFiaS8xMS4xLjAvcHl0aG9uIC0tZW5hYmxlLWxhbmd1YWdlcz1jLGMrKyAtLWVu
YWJsZS1vYnNvbGV0ZSAtLWVuYWJsZS1zZWN1cmVwbHQgLS1kaXNhYmxlLXdlcnJvciAtLXdp
dGgtc3lzdGVtLXpsaWIgLS1lbmFibGUtbmxzIC0td2l0aG91dC1pbmNsdWRlZC1nZXR0ZXh0
IC0tZGlzYWJsZS1saWJ1bndpbmQtZXhjZXB0aW9ucyAtLWVuYWJsZS1jaGVja2luZz1yZWxl
YXNlIC0td2l0aC1idWd1cmw9aHR0cHM6Ly9idWdzLmdlbnRvby5vcmcvIC0td2l0aC1wa2d2
ZXJzaW9uPSdHZW50b28gMTEuMS4wLXIyIHAzJyAtLWRpc2FibGUtZXNwIC0tZW5hYmxlLWxp
YnN0ZGN4eC10aW1lIC0tZW5hYmxlLXBvaXNvbi1zeXN0ZW0tZGlyZWN0b3JpZXMgLS13aXRo
LXN5c3Jvb3Q9L3Vzci9hcm12N2EtaGFyZGZsb2F0LWxpbnV4LWdudWVhYmkgLS1kaXNhYmxl
LWJvb3RzdHJhcCAtLWVuYWJsZS1fX2N4YV9hdGV4aXQgLS1lbmFibGUtY2xvY2FsZT1nbnUg
LS1kaXNhYmxlLW11bHRpbGliIC0tZGlzYWJsZS1maXhlZC1wb2ludCAtLXdpdGgtZmxvYXQ9
aGFyZCAtLXdpdGgtYXJjaD1hcm12Ny1hIC0td2l0aC1mbG9hdD1oYXJkIC0td2l0aC1mcHU9
dmZwdjMtZDE2IC0tZW5hYmxlLWxpYmdvbXAgLS1kaXNhYmxlLWxpYnNzcCAtLWRpc2FibGUt
bGliYWRhIC0tZGlzYWJsZS1zeXN0ZW10YXAgLS1kaXNhYmxlLXZhbGdyaW5kLWFubm90YXRp
b25zIC0tZGlzYWJsZS12dGFibGUtdmVyaWZ5IC0tZGlzYWJsZS1saWJ2dHYgLS13aXRob3V0
LXpzdGQgLS1lbmFibGUtbHRvIC0td2l0aC1pc2wgLS1kaXNhYmxlLWlzbC12ZXJzaW9uLWNo
ZWNrIC0tZW5hYmxlLWRlZmF1bHQtcGllIC0tZW5hYmxlLWRlZmF1bHQtc3NwDQrQnNC+0LTQ
tdC70Ywg0LzQvdC+0LPQvtC/0L7RgtC+0YfQvdC+0YHRgtC4OiBwb3NpeA0KU3VwcG9ydGVk
IExUTyBjb21wcmVzc2lvbiBhbGdvcml0aG1zOiB6bGliDQpnY2Mg0LLQtdGA0YHQuNGPIDEx
LjEuMCAoR2VudG9vIDExLjEuMC1yMiBwMykgDQoNCg0KUGxlYXNlIGZpeCwgdGhhbmtzIGlu
IGFkdmFuY2UuDQo=
