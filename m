Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B5E1BD00C
	for <linux-hardening@vger.kernel.org>; Fri,  2 Oct 2026 18:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790967121; cv=none; b=CFyiwY0/r0fe0b0iF4ZPrCzl890O8HTy6ygjeNLp41m+05B2Yz9fWk05sZLnSPU8mLhuCBVZSoR7dgMvOU4dj31lttpTwHFum75TCaf01/VQ5VCNqEBh162SGB46+WHHuPG23RukDrz+q4BBWxcrOkWxqT465/QhfO/QktgizBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790967121; c=relaxed/simple;
	bh=d+7Dzq3mPeyFPY32y86AvdtMGs9/cR+SwwsFl7j1jgU=;
	h=MIME-Version:Subject:From:To:Cc:In-Reply-To:References:Date:
	 Message-Id:Content-Type; b=E4alYNah8r0ldgdaXOoXLeoMraoJdk0Tj+TOsOxje1EvMviJvAbBTvXlnKBkTT4YiR+3x7/5Kiv/c6T3dOGBNMMWXuqJ+soUWKGQz4akbZWm5zftov42izRLjdQruSlPySrdPxmxRUNuLc3Cxa4CtNN/maWN5HMowVYafXqMqyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cULvCt0c; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cULvCt0c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790967118;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r0MvWYWwsu7LG0V0ETPW58ud5t6tmXACPDGuesfQVDA=;
	b=cULvCt0cs8apdmrxu4txQhDo5LIDOvTG6ohkt8OChz18DsHuvG3AozkhuuRh/fAIihvQjy
	CkQ7yydJ13cwCI/TxJslZSRz9o82nvjSWRwjxKMOxOoT1yhwzs7kzJYy9JylWLax2WHySq
	+wDXwWweSEbEOAXEzwodwqmmpEZ1xrA=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-icX8xXUYPWm-yDbWeXJdRQ-1; Fri, 02 Oct 2026 14:51:57 -0400
X-MC-Unique: icX8xXUYPWm-yDbWeXJdRQ-1
X-Mimecast-MFC-AGG-ID: icX8xXUYPWm-yDbWeXJdRQ_1790967117
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-939c30aa9a0so848851685a.0
        for <linux-hardening@vger.kernel.org>; Fri, 02 Oct 2026 11:51:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790967117; x=1791571917;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=r0MvWYWwsu7LG0V0ETPW58ud5t6tmXACPDGuesfQVDA=;
        b=Sag6TuUtlAPn+/aoq68Ry4lhqj6vX6el3XJXdqaWks/HuHrmuKv/SSIq10l0oKsXSS
         YNeVXRVY/b0EzR7oio8zh/FY/JZhTTOixhOZ6vA6xDZbG3dw3CR16xVWdlJwZkKtBOG7
         gqeZh3JYNlHd0ClBV0vNWH7H7KBp0UEI+uytHswej8bEaf+uujiS9DaXBsJfgewfrj/w
         OPgGEVfTR8D+aHm4JNtDTo3y7/aGpVNrEbu+QYVQK9kBzEBcRGFHg0Myz6/gr8ByI7UX
         3AKj0CDOmSr7zmtP7XYEXQTBMGMHPnQ7fuhsKwuW4g72UIF9eGYmLpspwUOE1NYhL7zF
         fExA==
X-Forwarded-Encrypted: i=1; AKwUvBxIck9rVRyPi5fSku8Fk4YRKYWKzIfXHncbDu7NyG1nlLCP/CIOZpuzj0LRWrqQrIXJqbsWqAiEeCvjoLm7yPM=@vger.kernel.org
X-Gm-Message-State: AFuF++n3nzOgYTxsoZqG+o8t1rd2OKacDhLYaSDPVJhoPudmBxcbY5yA
	XhmV1c7zla7rGkPc3SsKl6Qz77F75/07oVM/vDdhkAltci6F2Ho+NB1PNLdZYwktIxJUQT8fVGV
	4cXvo50HFkaRNO6PIPiXKQlaYav7XGvHWAxj4xZrk86iw2C4ltWXrsgTpsom60cWwl9xBLw==
X-Gm-Gg: AYBFou0XE+/4CHFT7e3TrO9GrPaBHHtJu7WFUbWTvg/2XVMPJq5bQl1fEJx5duus8vP
	TrgpkxRhu9CgR60Qkhlqfs/Wuk1jMtbbgj5cnrKeRBfqpbDulWVqUN+8l69fh10LD7Y1srBWOma
	roFAt44cVhf12EqFGV6Qal6kdA5C19pMEZll3aNdtGwMIi7HXqYwYnhN4irXNDBFM7APxu93bt6
	KrXaIUU0ZU+MuwHAxLfKlRxxdthP6BA5/ywqhX9KNyjBiwruoRmy6MxqtX6iyoJBG6O8kEWfghS
	SF0X/ZHh5d/nRXCSo6LbDMHnv5RbUrRjbUVtJ0kY8iQDJFYxMpUhQ/SEkwv8fT+Qu5gRlAxw5Ao
	2NFcaiZJEOjsPCA==
X-Received: by 2002:a05:620a:7105:b0:93a:824:ac8d with SMTP id af79cd13be357-93e5102406amr48502685a.27.1790967116822;
        Fri, 02 Oct 2026 11:51:56 -0700 (PDT)
X-Received: by 2002:a05:620a:7105:b0:93a:824:ac8d with SMTP id af79cd13be357-93e5102406amr48495985a.27.1790967116138;
        Fri, 02 Oct 2026 11:51:56 -0700 (PDT)
Received: from bmasney-x1.rmtuswv.csb ([2600:382:7723:4eba:66b1:961f:1a2d:af55])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93cca03a1bbsm290352485a.1.2026.10.02.11.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 11:51:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v5 11/23] dt-bindings: clock: Add StarFive JHB100
 Peripheral-0 clock and reset generator
From: Brian Masney <bmasney@redhat.com>
To: Changhuang Liang <changhuang.liang@starfivetech.com>
Cc: Michael Turquette <mturquette@baylibre.com>, 
 Brian Masney <bmasney@redhat.com>, Jerome Brunet <jbrunet+clk@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Emil Renner Berthing <kernel@esmil.dk>, 
 Kees Cook <kees@kernel.org>, 
 "Gustavo A . R . Silva" <gustavoars@kernel.org>, 
 Richard Cochran <richardcochran@gmail.com>, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-riscv@lists.infradead.org, linux-hardening@vger.kernel.org, 
 netdev@vger.kernel.org, Hal Feng <hal.feng@starfivetech.com>
In-Reply-To: <20260930124317.5648-12-changhuang.liang@starfivetech.com>
References: <20260930124317.5648-1-changhuang.liang@starfivetech.com>
 <20260930124317.5648-12-changhuang.liang@starfivetech.com>
Date: Fri, 02 Oct 2026 14:51:13 -0400
Message-Id: <179096707365.821688.14329539857628581125.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1426; i=bmasney@redhat.com;
 s=20250903; h=from:subject:message-id;
 bh=d+7Dzq3mPeyFPY32y86AvdtMGs9/cR+SwwsFl7j1jgU=;
 b=owGbwMvMwCW2/dJd9di6A+2Mp9WSGLL2/7Wx/KcQOOltnNfPrdMX3LuT/HC+0e60NpG6lD1rZ
 17q/rvbvKOUhUGMi0FWTJFlSa5RQUTqKtt7dzRZYOawMoEMYeDiFICJ/DvF8JvNMflnwRuHRRt/
 inec9nG6u3qLz7SmebNcL5042au9L+cTw28Wm8MCxyYbZ0apt67dn7TKUV08XMTt6JZbavvlIy/
 UbmYAAA==
X-Developer-Key: i=bmasney@redhat.com; a=openpgp;
 fpr=A46D32705865AA3DDEDC2904B7D2DD275D7EC087
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: stOvqp11PY2FwA6WjHhn3vK_Li9Ff2d6lOWr1XnNey4_1790967117
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi Changhuang,

> Add bindings for the Peripheral-0 clock and reset generator (PER0CRG)
> on the JHB100 RISC-V SoC by StarFive Ltd.
> 
> Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
>
> diff --git a/Documentation/devicetree/bindings/clock/starfive,jhb100-per0crg.yaml b/Documentation/devicetree/bindings/clock/starfive,jhb100-per0crg.yaml
> new file mode 100644
> index 000000000000..db43e03fd60c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/starfive,jhb100-per0crg.yaml
> @@ -0,0 +1,70 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/starfive,jhb100-per0crg.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: StarFive JHB100 Peripheral-0 Clock and Reset Generator
> +
> +maintainers:
> +  - Changhuang Liang <changhuang.liang@starfivetech.com>
> +
> +properties:
> +  compatible:
> +    const: starfive,jhb100-per0crg
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: Main Oscillator (25 MHz)
> +      - description: PLL6
> +      - description: Configure 400MHz
> +      - description: Configure 800MHZ

There's a mismatch here in the casing of the units. One line has MHz and
the other has MHZ.

Brian

-- 
Brian Masney <bmasney@redhat.com>

