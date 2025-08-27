Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854AA303CB6;
	Wed, 27 Aug 2025 12:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756296926; cv=none; b=NqmDnA50yEb6SmBn0cAYKNNez+jHwiy9t6xcUGPj05trcW52WK2Ji/H/ZaOiLhDT+9pa7rUPTs2/llmsrTrZ6hXuBUKWsoromDaEjPVkAPox6ACnxAOUs4pTbbtWcWAhIhqiFbWvt6aWvvdlOnxrL/VEsoiVeFwIC+KPrdAz3Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756296926; c=relaxed/simple;
	bh=4RXyP0M5mYncRYJ/RZ27T+ZgcfDjWi9oAGtWgYDaovw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jDqAkTjj40vKo4Jfz/IvZV0oDjRfxL9KdhCqFu68Yv/749V3mn6PxXhPR804FOjqrdJjQTwzPC0F2W4YSI9zWv+B7VV3XGnVp4xWQFJDQqT6VHN+0nfVS8uSMro43odBs5n+9Ebt8JNtAaXCeoDPB3DIyjrkEEngCl44E/yZHx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mlPTId9r; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mlPTId9r"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-45a1b004a31so51675555e9.0;
        Wed, 27 Aug 2025 05:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756296922; x=1756901722; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=deWal6fGTmJIA2DRBxXQwsqRR1CnN/qtvwinddrGd2I=;
        b=mlPTId9rHGVZ7Bhzh6lq6z+AFm9NXVlGFsdlX+tkTkwBvRVFwfYWw7QoEmAPT5sdQP
         83sTCfasyJRbI95i7tIZIgm9eZN4ce+FXnb49I03KV1mTZ0f4cuDV+i+pwhMYlmlwV/1
         pV7iYFK5LJI9oAUsBhjmuUCQnP9zbtt7SvweeTVWp4XHN3JdhnGrIMD+JrbHWWNUhk67
         7Yn0felirakQYSEYp3LhKdnyFKN1hh8wQ8eescgVRX4E6TumVtXOIEom4sGTXxGx+Gwt
         diPIZHahXrLMk6Fe3J5xdTe5APxSeMd7MsHvdywRLh6Z52vu3/0RSr76V3excLueT5vM
         qMkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756296922; x=1756901722;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=deWal6fGTmJIA2DRBxXQwsqRR1CnN/qtvwinddrGd2I=;
        b=BKH6y5IznxSYN+l+QSZEBvXNukOxgIsnBAgGupab+ctDBuuSzMvAqN2EJktExMqCi0
         slzeyis6DOlIKWou2JV21c2DAKhrLjuPlMCXlS7kAU6HU1AQJpNHAe4EXY16MxRRX62I
         mVltdX+jG+w0ZhAFXTXhYjN77FhWUvLY3yxkE7/d7A3bd+fn6G+daQsfyvfn3dI1ZzCs
         bDwPgHtShcxVWsUXFlLMJIiaDr6tvMgnbblFk6Yf7FRMTkoH9yuxAzwyfBXklMKv2CfH
         nzQWlkfRoa9nPWqMbo1m0A/voRPVszbAWuOnZB/Avu7wQAo0WEHz8Jzv4dO0afFlGDEx
         b/AQ==
X-Forwarded-Encrypted: i=1; AJvYcCVD5LxsSXUUcPKORVrmm0ZhdnY5tKkuqOJLV0958Yc5Op3bWSeYDvFZtTZEJg9U30p32vSBpts/KNw/tQog@vger.kernel.org, AJvYcCVqFIPiYaoHxYC0mP+ghg097yomTLJztE+RoZW3vjY5I2mNkiK4bJvR00ZMW2PCKV5pYp3c3AVrd6ek6LAwSv61@vger.kernel.org, AJvYcCW6Qe2jQoqAQiouNLX3bXVrVSfeHB2wl75Qv7P3X9QyEQIGw5zjGmieBeBBEijLdO/oP3+ZPzn8Sqn+@vger.kernel.org
X-Gm-Message-State: AOJu0YzmY9IZL8cIMzZ3l1bYtxY6oEvxY13/ZXT0frwGXdzn7olIcC6S
	lTJpqaSpPahqTN8+Ek/Vul/BVqU78Qwt+ImoGzkOoW/c60iD6oVilnEXhYzBAMehxHKyAA==
X-Gm-Gg: ASbGncsjl3XSPLVpjBZyxweFhRsuA4pLQuzep+78DNxDCVKZB1cbt/GZECQmSJ3Xli/
	6HLrj58BCrqSeouU+GXE7O5jdkQ+9o3LKGk7A+8ivzuGWvhwaJvJILVSC3AhfQm58ZlwI76EixI
	QUTi1ndnikB5Nxr8leI972Z0IpOHWEc64CP6EyBtNZM6NtqQhWd6ATJjJwkAF64ff0EjDhaCPst
	phjU6N0lk3mbR74KtwCF2s5tXoQiI+N4QeIM2/DXRy22zAsoX+aUytcDRi0JnwUFRAAAQsMDRly
	TCX9S6UctrcFd8BH170Vg+oY4MVHeocy3k3Y2VFfubWZSZebIjclxJF/RDFvJygRiOe9IeJrtB2
	Z0cbvI8q46Zea8A3W7CP0tRmOHuCpgt1lNGG/9FGFaaQ/EvdatHx5EIf4uPH+gCH6MhMaLQZBXT
	sOMA7+b0pImw==
X-Google-Smtp-Source: AGHT+IH7ZMKSdqmekj5haFzANAciqUU5tKO1zCWwczU/8ZOjMqgAYLGB6etXPY1O7g1rn4Nha+5qqA==
X-Received: by 2002:a05:600c:1c0c:b0:458:bda4:43df with SMTP id 5b1f17b1804b1-45b727a2c43mr16217345e9.17.1756296921471;
        Wed, 27 Aug 2025 05:15:21 -0700 (PDT)
Received: from HYB-DlYm71t3hSl.ad.analog.com ([137.71.226.91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c70eb7eed5sm19747374f8f.18.2025.08.27.05.15.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 05:15:21 -0700 (PDT)
Date: Wed, 27 Aug 2025 14:15:18 +0200
From: Jorge Marques <gastmaier@gmail.com>
To: Frank Li <Frank.li@nxp.com>
Cc: Jorge Marques <jorge.marques@analog.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-i3c@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v7 0/2] Add ADI I3C Controller
Message-ID: <4cnv4s5puov5xrzfvv4fn4ndwup6g5kpbeiwjaybqcvacw7tvj@hfr2cusdxr5m>
References: <20250818-adi-i3c-master-v7-0-f7207902669d@analog.com>
 <aK3ZFSQ9FUwuxT12@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aK3ZFSQ9FUwuxT12@lizhi-Precision-Tower-5810>

On Tue, Aug 26, 2025 at 11:56:05AM -0400, Frank Li wrote:
> On Mon, Aug 18, 2025 at 01:51:12PM +0200, Jorge Marques wrote:
> > I3C Controller is subset of the I3C-basic specification to interface
> > peripherals through I3C and I2C. The controller RTL is FPGA
> > synthesizable and documentation is provided at
> > https://analogdevicesinc.github.io/hdl/library/i3c_controller
> >
> > The main target for the I3C Controller IP is low-cost FPGAs.
> > In this version the driver supports IBI (only the MDB), I3C and I2C
> > transfers.
> >
> > The IP Core is versioned following ADI's open source HDL guidelines
> > for devicetree bindings and drivers described at
> > https://analogdevicesinc.github.io/hdl/user_guide/contributing.html#devicetree-bindings-drivers
> > in summary, follows Semantic Versioning 2.0.0, with the dt-binding suffixed
> > by -v<major>.
> >
> > If necessary, the contents of
> > https://analogdevicesinc.github.io/hdl/user_guide/contributing.html#devicetree-bindings-drivers
> > can be replicated to a file in a different series, similar to AMD Xilinx
> > at Documentation/devicetree/bindings/xilinx.txt, but as adi.txt or
> > similar.
> >
> > Depends on https://lore.kernel.org/linux-i3c/20250622-i3c-writesl-readsl-v2-0-2afd34ec6306@analog.com/T/#t
> 
> It is already in v6.17-rc1. You can remove this depends.

Ack

Best regards,
Jorge
> 
> commit 733b439375b494e8a6950ab47d18a4b615b73cb3
> Author: Jorge Marques <jorge.marques@analog.com>
> Date:   Tue Jun 24 11:06:04 2025 +0200
> 
>     i3c: master: Add inline i3c_readl_fifo() and i3c_writel_fifo()
> 
>     The I3C abstraction expects u8 buffers, but some controllers operate with
>     a 32-bit bus width FIFO and cannot flag valid bytes individually. To avoid
>     reading or writing outside the buffer bounds, use 32-bit accesses where
>     possible and apply memcpy for any remaining bytes
> 
>     Signed-off-by: Jorge Marques <jorge.marques@analog.com>
>     Suggested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
>     Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
>     Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
>     Reviewed-by: Frank Li <Frank.Li@nxp.com>
>     Link: https://lore.kernel.org/r/20250624-i3c-writesl-readsl-v3-1-63ccf0870f01@analog.com
>     Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> 

> >
> > Signed-off-by: Jorge Marques <jorge.marques@analog.com>
> > ---
> > Changes in v7:
> > - Edit cover linking guidelines to ADI IP Core versioning.
> > Documentation/devicetree/bindings/i3c/adi,i3c-master.yaml:
> > - Extend second clock description to explain relation to synthesized topology.
> > - Link to v6: https://lore.kernel.org/r/20250717-adi-i3c-master-v6-0-6c687ed71bed@analog.com
> >
> > Changes in v6:
> > - Format 0x05C undercase
> > - Link to v5: https://lore.kernel.org/r/20250715-adi-i3c-master-v5-0-c89434cbaf5e@analog.com
> >
> > Changes in v5:
> > Documentation/devicetree/bindings/i3c/adi,i3c-master.yaml:
> > - Use semantic versioning major field for dt-binding compatible, with
> >   the format adi,<ip-name>-v<major>
> >
> > adi-i3c-master.c:
> > - Rename MAX_DEVS to ADI_MAX_DEVS
> > - Encapsulate REG_CMD_FIFO_0_DEV_ADDR var
> > - Reorder struct adi_i3c_i2c_dev_data fields
> > - Start addr at 0 instead of 8 at adi_i3c_master_get_rr_slot
> > - Minor rework on adi_i3c_master_handle_ibi to most logic out of the
> >   lock. Even if length is 0 (BCR[2]=0), the mdb field is extracted and
> >   written to the slot buffer. Since the length is 0, the written data
> >   doesn't matter.
> >   In a future update with additional bytes support (e.g., bits 31-23),
> >   len would be incremented and an IBI FIFO would be read.
> > - Version check against first stable release, major v1.
> >   Driver+RTL features updates affect the minor field, therefore check
> >   for major == 1.
> > - Link to v4: https://lore.kernel.org/r/20250626-adi-i3c-master-v4-0-3846a1f66d5e@analog.com
> >
> > Changes in v4:
> > Documentation/devicetree/bindings/i3c/adi,i3c-master.yaml:
> > - Add -1.00.a suffix where missing
> > - Extend clocks descriptions
> > - Add minItems to clock-names, to match clocks
> > - Use header in example
> >
> > adi-i3c-master.c:
> > - Regmap:
> >   - Add new controller info registers (dyn_addr, dcr, bcr, pid)
> >   - Always decreasing fields
> >   - Add line break between registers
> >   - Reformat REG_DEV_CHAR_BSCR_IBI to use easier to read FIELD_GET,
> >     FIELD_PREP
> > - Read controller info from regmap with explanation comment
> > - Use linux/fpga/adi-axi-common.h macros
> > - Use __counter_by macro on ncmds
> > - Use __free macro
> > - Use new i3c_writel_fifo and i3c_readl_fifo macros
> > - Rename bytes to buf when nbytes is present
> > - Use scoped_guard instead of spin_lock, spin_unlock
> > - Reformat loops to read fifo status, use while single line alternative
> > - Drop adi_i3c_master.max_devs, use MAX_DEVS directly
> > - Use devm_clk_bulk_get_all_enabled, dropping clock name match (CHECK_DTB does it)
> > - Init spin_lock
> > - Init list head
> > - Link to v3: https://lore.kernel.org/r/20250618-adi-i3c-master-v3-0-e66170a6cb95@analog.com
> >
> > Changes in v3:
> > Documentation/devicetree/bindings/i3c/adi,i3c-master.yaml:
> > - Small reworking of the description
> > - Add -1.00.a suffix to compatible
> >
> > adi-i3c-master.c:
> > - Misspelling
> > - Remove REG_CMD_FIFO_0_LEN_MAX since it is a HDL parameter
> > - Use adapter timeout value for I2C transfers, as in
> >   https://lore.kernel.org/linux-i3c/aEBd%2FFIKADYr%2F631@lizhi-Precision-Tower-5810/T/#t
> >
> > - Link to v2: https://lore.kernel.org/r/20250606-adi-i3c-master-v2-0-e68b9aad2630@analog.com
> >
> > Changes in v2:
> > Documentation/devicetree/bindings/i3c/adi,i3c-master.yaml:
> > - Move allof
> > - Rename clocks to axi, i3c
> >
> > adi-i3c-master.c:
> > - Update license year
> > - Rework regmap to use FIELD_GET, FIELD_PREP
> > - Reformat regmap to have FIELDS after REG, prefixed by reg name.
> > - Add overflow safeguards to cmd, tx fifos
> > - Fix macro related macros (mostly erroneous `| ~BITMASK`
> > - Use guard macros, remove goto.
> > - Simplify daa logic
> > - Replace devm_clk_get with devm_clk_get_enabled
> > - Solve 64bit->32bit warnings on x86_64 systems by casting to u32
> > - Immediate clear irq request flags, then handle it.
> >
> > - Link to v1: https://lore.kernel.org/r/20250604-adi-i3c-master-v1-0-0488e80dafcb@analog.com
> >
> > ---
> > Jorge Marques (2):
> >       dt-bindings: i3c: Add adi-i3c-master
> >       i3c: master: Add driver for Analog Devices I3C Controller IP
> >
> >  .../devicetree/bindings/i3c/adi,i3c-master.yaml    |   72 ++
> >  MAINTAINERS                                        |    6 +
> >  drivers/i3c/master/Kconfig                         |   11 +
> >  drivers/i3c/master/Makefile                        |    1 +
> >  drivers/i3c/master/adi-i3c-master.c                | 1019 ++++++++++++++++++++
> >  5 files changed, 1109 insertions(+)
> > ---
> > base-commit: 51963783b876a2f493a3eac0ea9eba271cb6809a
> > change-id: 20250604-adi-i3c-master-2a5148c58c47
> > prerequisite-message-id: <20250622-i3c-writesl-readsl-v2-0-2afd34ec6306@analog.com>
> > prerequisite-patch-id: 5443f14ca82fc08593960fafdb43488cce56f7d9
> > prerequisite-patch-id: 647084f5fe09f4887f633b0b02b306912a156672
> > prerequisite-patch-id: 6f582bb2ef1aafb66f26c515a19d5efa06ab8968
> >
> > Best regards,
> > --
> > Jorge Marques <jorge.marques@analog.com>
> >
