Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792762766;
	b=KUr4T8zVRHG/3l5HL3AdWkw7rMeReNrKAHhP4xwZZd3D72BuJmKiY5aqEzmJERivjSUf
	 0fXV04a5v+gJ0mpaCAPCwsJF4OIzpWSv0VjjyXifBAwHcMJnzFLorXOUY/m5Y6QzeGuEd
	 CIV2J8t0Un3mXAQbDXY2yxX2PlDXdnd/e/HSHzJ+IAJe8VHWO1pS3IB96nEMZBAyHPfYn
	 rbrkXoIvXXw6kQqIdeWZ2tr/XmM9TFCdLDBfTb6sTUW1/4xthbWm23/POVbCIuZX74qT4
	 f8jeJKBqnY0B+Zoa+SL7T4tzWQSIvkPhQb+F36Sqi05ztP1VkNC/tgCwaEEvp947LAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792762766;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=q/FXb9aWk8RMV4mySgy4meuQjo/Ip780RyKlEE+DHWA=;
	b=JTjYcuW5aklvcum6kGxqmrsx99S3hSD8REjYJMWxSarJ6lGxE7g0aMqVbNEIe2v32nA+
	 RycdfG9+Xvd/XsYUQ5lpxaKcZSspYUfbre4SgK0m9ojLI4Y8+UWJOJY53zOXp5ibSCOCP
	 k5oHMoY4KZ++G3PAdVX0CIdGR9WOP84tGHQ7w5UM4c+bTCdbIjL8+V0bEcXAccCUL2RzN
	 rqZDaErsBcFKVcFReb8Ysxj/KiBIVmhLK2desijdlwx2EXHVCRgTt6LgTYvvaGnPtshyz
	 GYztJV/cAP/fD6hrB0s+hPR3+TZSgHBO0FBmmGUCk15FmazEz2kPp5KmMRW3P3s1NiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-m68k.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.218.50
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E04B606A326
	for <linux-hardening@vger.kernel.org>; Fri, 23 Oct 2026 13:39:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9E04B606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c40e02b2ebaso144050666b.1
        for <linux-hardening@vger.kernel.org>; Fri, 23 Oct 2026 06:39:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792762764; x=1793367564;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=q/FXb9aWk8RMV4mySgy4meuQjo/Ip780RyKlEE+DHWA=;
        b=k+owSTUpqzaH1hek0319tUQ/2lYTvlTxejtz62+qTaashPhfOo2u+Uw5JuueHT5Is7
         cV8l8rxxIvxRVkBLFQ96FBF4UUXVLl7qGbI/vH8uuqHdVFVy0VtNanwJkoKkKX93lSHm
         wnB0h9Q7YznFlznHdGEy7AyEekMhp/0pfc/wUm3LDZ/a4t6Cx3T9+RBrGXrLNMus8c5j
         8csiJrbkfQqdmTgxyEoEVgyNeYPgaXboTyDNwUQ/c/8eDtq189Z8WSPLiDO0+G2TH+PO
         5VQ7dArcCYMkNZvUU+TZlAz8TfR5j/ThC4f7e0CNbOq1dnafVbnhh915SLMsmkcQwNXD
         x6/Q==
X-Forwarded-Encrypted: i=1; AKwUvBwUvAwYfIoyA6p0zZgE5r/di0WtRKIVKs9fIzzJAnzUw7jXVz3Ch3nQTyJcHTzuxgqqhqVRTvyMmtqJmGrO9Jg=@vger.kernel.org
X-Gm-Message-State: AFq9FYIL9rh7bVZZdttPmg45h4JTSiJGo2O8cMANPip0Xz5khan1gJi5
	vDMjnUJEdXquPtNtqoGllhPvK/QXsPI9XiFQZ+iLddllVVa+omu97AyNSHRCSwdlscc=
X-Gm-Gg: AYBFou3YVmvbfVcOezc2GTGCXgLxXUtSB4O5ps1vLCu5GDl1kpQ/9Jxqmt4iKRtqPML
	n/n9rJr/6IBQ/51FpSsnHFbGiK5oKYDDUJBsOyZnBY7sJ/OpPg4gz+KFwiRljfw5WqYBJw7C8Eu
	6DI9xmy/eyQ98hYTlbc+UbMhuCk6PtQ+D6ZrdnfdNGfauzMhFfMbMgc4uvwf6RVCQ/1yJY92TIN
	sDknKciwB7WEcCxrvM/Y9LBUqe3o9hsrB3pCATtYBnzJdHDVFZXjhQ9DJODAz+L8lbPzgnWn09P
	TOJ5H9nmkHmJ3eI9kYr8+ZoatMuukwi8J5aQqKN01ARbGYnpIiigvWUX12Eb2N10LiseCMkCvsP
	l04kPRnXVWoBKh92H6aWo274BVJbXcqK8skV2QU1JovvhAHJcTNfAuGYcY7TRHDQMCdNLgDtnyX
	F0UDTuhmzEwVl55umQRteGztVsgXK/wQygbJp+1nrR4KfU7TcSG+erBGyH1eB20fBwxvYIpJuiX
	nOh8MPM4Hg2/kJddtsmy0xEPI/j22Q2BP4npAUWdj/IdhSW/dkdc8Oi1/wYAw0AHzY2K5Q2gaZ3
	LgtWTp2o65cBVTGOI2Q=
X-Received: by 2002:a17:907:da7:b0:c44:16ad:c31d with SMTP id a640c23a62f3a-c46a9008aefmr353234366b.4.1792762763805;
        Fri, 23 Oct 2026 06:39:23 -0700 (PDT)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b432c9608bsm1098602a12.18.2026.10.23.06.39.20
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Oct 2026 06:39:22 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6b3dd83e779so1437840a12.1
        for <linux-hardening@vger.kernel.org>; Fri, 23 Oct 2026 06:39:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxtYVVw042JIOtcUV9QvZfaVdvi0mkFAHvvuZ+Xdr5JCf7+GxTFoDcY04MXxfX6Q3FaGNAXH7WsBllOXb6uZ5M=@vger.kernel.org
X-Received: by 2002:a05:6402:1f11:b0:6b1:d148:5a0a with SMTP id
 4fb4d7f45d1cf-6b432be9346mr3876276a12.19.1792762760594; Fri, 23 Oct 2026
 06:39:20 -0700 (PDT)
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261014-dev-mctp-usb-lib-test-v3-0-ee5bc3ea1db1@codeconstruct.com.au>
 <20261014-dev-mctp-usb-lib-test-v3-6-ee5bc3ea1db1@codeconstruct.com.au>
In-Reply-To: <20261014-dev-mctp-usb-lib-test-v3-6-ee5bc3ea1db1@codeconstruct.com.au>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 23 Oct 2026 15:39:06 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXTGGdGWZ9sKz5_sQF1237gV844cEhkXr6v_TUHPOb78Q@mail.gmail.com>
X-Gm-Features: AclHuK_taSWkqoWJ55TGYbrilVkTwq1Avu2z2PyWM4RMVHph7TJaMbjqEHNy60Q
Message-ID: <CAMuHMdXTGGdGWZ9sKz5_sQF1237gV844cEhkXr6v_TUHPOb78Q@mail.gmail.com>
Subject: Re: [PATCH net-next v3 6/7] net: mctp: usblib: Add initial kunit tx tests
To: James Lee <james@codeconstruct.com.au>
Cc: Jeremy Kerr <jk@codeconstruct.com.au>, Matt Johnston <matt@codeconstruct.com.au>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi James,

On Wed, 14 Oct 2026 at 06:54, James Lee <james@codeconstruct.com.au> wrote:
> Add tests for the transmit path, where MCTP packets are handed to
> outgoing USB transfer data. Testing a spanning transfer that is expected
> to succeed, the failure paths when sends fail, and large sequential
> sends.
>
> Signed-off-by: James Lee <james@codeconstruct.com.au>
>
> ---
> v2:
> - Correct flex array reference
> - Simply return when mctp_usblib_test_tx_send() fails
> - Use skb_put_data() instead of manual assignment
> - Remember span parameter exists

Thanks for your patch, which is now commit 1e12f734afc10477 ("net:
mctp: usblib: Add initial kunit tx tests") upstream.

> --- a/drivers/net/mctp/mctp-usblib-test.c
> +++ b/drivers/net/mctp/mctp-usblib-test.c

> +
> +/* Test sending multiple packets in the same transfer, followed by one that
> + * spans multiple subsequent transfers.
> + */
> +static void mctp_usblib_test_tx_multi_push(struct kunit *test)
> +{
> +       struct mctp_usblib_test_ctx *ctx;
> +       size_t i, max_length, tx_length;
> +       struct mctp_usblib_tx_ops ops;
> +       u8 *buf, *flat_tx, *index;
> +       struct mctp_usblib_tx *tx;
> +       struct net_device *ndev;
> +       struct sk_buff *skb;
> +       const struct {
> +               size_t len;
> +               bool more;
> +       } sends[] = {
> +               { 1000, true  },
> +               {  500, false },
> +               { 5000, false },
> +       };
> +       int rc;
> +
> +       static_assert(!sends[ARRAY_SIZE(sends) - 1].more,
> +                     "The last push must claim there will be no more");

This fails with gcc-14 (the latest available in Ubuntu 24.04LTS)
and earlier:

drivers/net/mctp/mctp-usblib-test.c:819:23: error: expression in
static assertion is not constant
  819 |         static_assert(!sends[ARRAY_SIZE(sends) - 1].more,
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
