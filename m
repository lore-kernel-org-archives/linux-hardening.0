Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0740128852B;
	Wed, 27 Aug 2025 12:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756296762; cv=none; b=J+MM0lOjkrHXMfZheb8cXBMEDqUzTPkmExa3etiIFqYLno3aMTAVCgO3uoBWnRanWmYTskE7YaPcT2b6uJVIemboYIfD/kSQ8UaXJKa3mt/5tuWbRm/cikBMNI7QqqfLJvM6AVJSij5G0ch+3QNpr2qRJfJVK/RuVO64JvO3uOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756296762; c=relaxed/simple;
	bh=hlck+XYQbusOHqFkKadFBA+4ScYnSRHeII5YwBFkvDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Au3Ucgb6kuSEDqfpwO7wwc3Hv71YySasIjQFuvfi/fJ6I7T/LobxuN3i4YHNEHmBZOjvpBFcF0CfL7bKrhmqFnSKsAJX01EmmB7JZvaZcJnFzet9Dqcxd9/Vn/JFkuHQ1erzQf9azh8Ij9HTx/GsBLaYOVp/dj7r4JBwEkUzyYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nn7/mY6j; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nn7/mY6j"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45b6b5ccad6so5366325e9.2;
        Wed, 27 Aug 2025 05:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756296759; x=1756901559; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3fqtEW6MzsEkiAa8sZI303qQp8qzeB/9P13/CzJ1Hgc=;
        b=nn7/mY6jmb/SuIfLnN4DC6lHrFlUalMxT4CI4Fss9QtkOo6xWlW4sWT6JDO0wnvDw7
         b4s/BskFIcgjydrEFPJg095HWp3ccjEFSDOewrOHvr36rCiHcz81vctfp3Q1NPKlqSuN
         H9RHAyK9+qKu23LGqS2dnw4p/hloHsSmEfgF2mYatfyOCJ+x39YVIGh24BfgeX8Pq4vj
         BgshR5v3SADvGb8YD/mjK9pusgnkAkRlTqJZN62tR4IG709VEeC9kzXaaBoKVs7ugiYy
         +k7eG8AR6MNutd2MysGUpO4sPbNQeMAH1HPvo5Z16Z8nv0MrwLEeB8Syyhhj88y9sEK4
         YlFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756296759; x=1756901559;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3fqtEW6MzsEkiAa8sZI303qQp8qzeB/9P13/CzJ1Hgc=;
        b=rJId22igfQGutCVJDxWrhqkMIiDEqQD0E61c6VlXImC4Y0rkyDIQ0YiWJDYu6c7ehq
         TaMX1SrgNnGr6EztW5SYUHDp5GjH3bGpDAiuq1Pab7ahk0iYdML1BubttlmZyEz7KN4+
         t22thM3LT5f2vN81IrJWNzQXe73hYh9va5Z0TBB14SnUg8bmqrWy9jIt8pfO4r3/1e8W
         0JwxIOLqUq720YfKow5zXS0vNSk6Lla5Nm8VExr90eNTP1Q/pc0ZbfE0qq0U/5nLSaqR
         DLmM1AxPgUDZj7LcT+wOVP+uYBFBr7hw80/XODVIWFkk8yu5XoHe0IxfaP5sGj/0/coq
         Wozw==
X-Forwarded-Encrypted: i=1; AJvYcCV3k0XVUiQd75wJFWT8xSLtByHiIaXyMkhdZ2NrUPl8Ez9InofSVSZsg77CXpq9jJ3Qx4o5fjJkEVIF@vger.kernel.org, AJvYcCVUN0jyHIi9F3uogv4LljI4io3jMoEVwduu4f7VebhrlAAQ9yqVa541hHC5AggaJZN6eULVeFjhpJp3hXDyPxMu@vger.kernel.org, AJvYcCVW4kN/7VM4ORV4WZ9JIzdl+EYdW0kQNorzE/1NOX/ruKc7mslNQE5owaJFj39owxRqQp9bmpp2hGM4Yx48@vger.kernel.org
X-Gm-Message-State: AOJu0Yynqw4/UtdyW2L3A7rZBMp4nYjJcnlA8VPlxXvvbCx80KVyK5sP
	6Q+6f8OAYYlb3drZvtnEB9SnLIL3UPaerB7G/gUeAZUngSLa9p7Qa+Hr
X-Gm-Gg: ASbGncvtVMpanZUiKVyCC0ZlOdXjIY+IWh5CyRejHklaTt57xP/gvsRCsKFgFqf70ca
	FnPaqXX8gUhwSIjCmj/9qwGnQArKpyhigSuPAkRp1jeszPiVuQOjQLUfvSJLRUH25gNC4iYU0l6
	DxttLzhjutheVAbQ/CYftg3WaV0sFUQPnSysRl5dvHzNbTt3aO3KGSfQSlvU8wc1evJM1OUUJb1
	sNRPJy1UTBAorySNghitmkitdQEAXlFYYL/TuXOJ+MAYcU8CnHtSQWYtzCtdBbuKXVuHXlTKwE2
	a7D84IvCCls+U6YhERYVxb+8NCbOvu4T7R3PVQpcX8EkXPKeSu/oJE9/cL3VlHVrPcVmV9vSZya
	vmlJKpjAGYMbQBD89zGtmATEXVJ2pzHca1u1m9ROhcZrVyRvTZRRP9vDncHLFI7G9w9zl8sGOkz
	i40ExoOtfc1w==
X-Google-Smtp-Source: AGHT+IHCen0twgH6SvYKDmE3fl0I5US28XRM01Jr2EAWZqrWDSRoLBba6HDsA3DR9QxoWEzXw8khSQ==
X-Received: by 2002:a05:600c:1d28:b0:45b:6285:e22a with SMTP id 5b1f17b1804b1-45b6f30756dmr19899945e9.23.1756296759064;
        Wed, 27 Aug 2025 05:12:39 -0700 (PDT)
Received: from HYB-DlYm71t3hSl.ad.analog.com ([137.71.226.91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cd2e01dd9dsm1237895f8f.60.2025.08.27.05.12.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 05:12:38 -0700 (PDT)
Date: Wed, 27 Aug 2025 14:12:35 +0200
From: Jorge Marques <gastmaier@gmail.com>
To: Frank Li <Frank.li@nxp.com>
Cc: Jorge Marques <jorge.marques@analog.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-i3c@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v7 1/2] dt-bindings: i3c: Add adi-i3c-master
Message-ID: <5zd2lxv25pza33opo4khevfwna2iqjbe4jb3t4mo473sjgxuou@o3glpcmohmun>
References: <20250818-adi-i3c-master-v7-0-f7207902669d@analog.com>
 <20250818-adi-i3c-master-v7-1-f7207902669d@analog.com>
 <aK3XIUpVZYmHGiUz@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aK3XIUpVZYmHGiUz@lizhi-Precision-Tower-5810>

On Tue, Aug 26, 2025 at 11:47:45AM -0400, Frank Li wrote:
> On Mon, Aug 18, 2025 at 01:51:13PM +0200, Jorge Marques wrote:
> > Add bindings doc for ADI I3C Controller IP core, a FPGA synthesizable IP
> > core that implements the MIPI I3C Basic controller specification.
> > The IP Core is versioned following Semantic Versioning 2.0.0 and
> > ADI's open-source HDL guidelines for devicetree bindings and drivers.
> >
> > Signed-off-by: Jorge Marques <jorge.marques@analog.com>
> > ---
> >  .../devicetree/bindings/i3c/adi,i3c-master.yaml    | 72 ++++++++++++++++++++++
> >  MAINTAINERS                                        |  5 ++
> >  2 files changed, 77 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/i3c/adi,i3c-master.yaml b/Documentation/devicetree/bindings/i3c/adi,i3c-master.yaml
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..fda240f9ee0c73bcbea97f775d6e081fe0c089d9
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/i3c/adi,i3c-master.yaml
> > @@ -0,0 +1,72 @@
> > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > +%YAML 1.2
> > +---
> ...
> > +
> > +  clocks:
> > +    minItems: 1
> > +    items:
> > +      - description: The AXI interconnect clock, drives the register map.
> > +      - description: |
> 
> Needn't | here.
> 
> Frank

Ack

Best regards,
Jorge
> > +          The secondary clock, drives the internal logic asynchronously to the
> > +          register map. The presence of this entry states that the IP Core was
> > +          synthesized with a second clock input, and the absence of this entry
> > +          indicates a topology where a single clock input drives all the
> > +          internal logic.
> > +
> > +  clock-names:
> > +    minItems: 1
> > +    items:
> > +      - const: axi
> > +      - const: i3c
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - clocks
> > +  - clock-names
> > +  - interrupts
> > +
> > +allOf:
> > +  - $ref: i3c.yaml#
> > +
> > +unevaluatedProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +
> > +    i3c@44a00000 {
> > +        compatible = "adi,i3c-master-v1";
> > +        reg = <0x44a00000 0x1000>;
> > +        interrupts = <3 IRQ_TYPE_LEVEL_HIGH>;
> > +        clocks = <&clkc 15>, <&clkc 15>;
> > +        clock-names = "axi", "i3c";
> > +        #address-cells = <3>;
> > +        #size-cells = <0>;
> > +
> > +        /* I3C and I2C devices */
> > +    };
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 35ed8498ab1e9b92b4bce5db9bb64004d80e4b1a..faa50535b514037ddf97309874ec64aac2013cb6 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -11452,6 +11452,11 @@ S:	Maintained
> >  F:	Documentation/devicetree/bindings/i3c/aspeed,ast2600-i3c.yaml
> >  F:	drivers/i3c/master/ast2600-i3c-master.c
> >
> > +I3C DRIVER FOR ANALOG DEVICES I3C CONTROLLER IP
> > +M:	Jorge Marques <jorge.marques@analog.com>
> > +S:	Maintained
> > +F:	Documentation/devicetree/bindings/i3c/adi,i3c-master.yaml
> > +
> >  I3C DRIVER FOR CADENCE I3C MASTER IP
> >  M:	Przemysław Gaj <pgaj@cadence.com>
> >  S:	Maintained
> >
> > --
> > 2.49.0
> >
