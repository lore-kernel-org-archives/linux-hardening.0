Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793915397;
	b=xFU+JriNSDSU+kKcE3IxdAvVIOVPNSodHWDSfywJSUqr6JPk921+/moan0rGTEqB8hXf
	 ZpxyM2SvoLeYq+ETIqMqSfhnfK9X2cqjSLpWPcZeCRilelTRbRxaRXYmajBelXn8iLUvk
	 TbBLBxN7S6jiUAm8p+6r/kN0os5RqOSyKgoXWIJxdyBHwj8NIcgr6L3Go5SEClJSG42ok
	 RXQEev1hxB9oK0EUfzhv3kHSMIBxoFCNixbPIQA0o2JESyzSbG0yIYRJHlUXFWZ7E5ocj
	 Fj0qHIS1cKM1YfH2Raxo26UmmjlL2y+S+cYJfdKodGQ91o3Wh1rA3jNuSj/oQeNkZ7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793915397;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=oHIzt9l6ZqX1+4fgIF4dpM8hMXfpU4Wy6+rPpNQD3cg=;
	b=o4wF+5yKz4tN9KVf9aMhDxJsdtvGP9O+QErcve0J8eGEYMCYpggDBEwQypIsvcZN8Hk+
	 OIb087czmnEHA8NQJJ4ZkDSV6nA8W5/96pdy//vmn4r4Fq5BMQB0nHt2ssp9ARcJ9+CgI
	 1zgH1UEmZE37xe0zq8gtIERkxC1O0HT3CNHknjhXo9fHgiOfOYMLuGl4dKosY1/JRbZ/8
	 +xJAi18JUDvwse4yK01+hsbXHRIpT9I6CbCa1NYEWb5nbV2Q6/7tP7dv13RlHtYYewYFz
	 tI/hLQnwsiaP63r9tuD/kXY3bOD1SQKb5N2mPN0eaQddH426wPiIQ4b43zhsg1bjWJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gompa.dev;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.161.44
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14228606A31B
	for <linux-hardening@vger.kernel.org>; Thu,  5 Nov 2026 21:49:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 14228606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-6e560e00a86so32028eaf.1
        for <linux-hardening@vger.kernel.org>; Thu, 05 Nov 2026 13:49:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793915396; x=1794520196;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oHIzt9l6ZqX1+4fgIF4dpM8hMXfpU4Wy6+rPpNQD3cg=;
        b=mfVbT8VI5KU2Dcht5nKLUaMjfFbOptwG39zW+CzOJ3pTmDombn/tDX0BLCyqsiLJTe
         d94poY0TSM9K+CHF1n313tr0+0sW+8Y21yhEMXdhbonD9NlrYr3eWZ8WjSOCSfDzfC1/
         fQ8F9XiQxTf31KHMw6w41OoU00CbZFw4zDpONFPivVXIbN44X+QFD2YN/VKlZrRTBp07
         tKg2SmKN6VsuBNKIWwQ/kFtWVG2YqtCETgK+id61scqCj4R20sh2Cq8ou0tzCJDZs8yU
         xudhQzTtb9cjzvKnpEJeX09+zvexV1LLPZTY4m0ATF2h2XTNCypzTp4mT5wZytFP1wvG
         fZsQ==
X-Forwarded-Encrypted: i=1; AKwUvByAh1i6O0SIKDjUu5mR6g7VYM+/VyuqLIN5rVI3BSDokPeS3oFDB9KjZAp1tVW4+60wOzMxAJ4mRutCY1lohGU=@vger.kernel.org
X-Gm-Message-State: APuU4Z9lFHTLGa8CUrBiXraZE/+QQzUI+uF6wZ8UUo49hez0Aa+odTko
	avHW/Me+TNZftgk3/MyZWolaABm2fMhXExkk8hGy1oqlnxd3SXOOMLCglMMkEgZs
X-Gm-Gg: AYBFou1NgxdfOp5Is6Pcdrs2Lov8gzLoUNQ8Hx3PBlvNF12K6ijh1tO2jtLtoHh8iW+
	xa1d/Xecc5TWRVEYXh/7k/cXBtjvyrAyCYkHLS3hsuhdtLlPjqMy97/JLnX2nxiRCtgFzelIZQ4
	GMBsi0xo6CYIB3h3ZEOYE8lFOMKmoPsK/+F7chE2rjf0KnZtZAnbUzW9uXnJ9qGcCtRiQxOe8mb
	ydtX65KbbKu2t5g+CH9ueR41T453KVrsa2zNUJfWVKq3CG02HvfWfGf1jWrGB23c74eMmpVrRUD
	75uzCWz3w4oelGwiE2KgMmuDQag65oA6+f2/nbU34ZD+E/IbCigyN9GY0/hMW7nIbC4QxiGuVhg
	UsQLrAb4MXIHxvqbTYP5v0T5bdpurkYav5Yf6AWtfYp4B5HkJCBh4ze5ad5yHAP89PiZqwbHUm5
	GdCdj6MOKzl/PEy1proANjq4FOfCMu++aw1ByauMKnwee019UtdI2yCqGITGqIkvbqGZxnTvfgb
	wJXrjCBLNDJmP+2gnQ3wNX7rAzv3D36V8l9oIyO00PwF6pRJcH2d1rUihkbDlr7xQ7ziSqJNyFb
	EfTWJ7Cl71YI4N49WRzn0aRK+AOCtuxLBol2btN+o5ZadGYUZUU//S7YiNz44YBiR5LOJmRr9TA
	H+Ha+qSFQCQi7Nc14gPw0LLV2lDYPiB0cDw1wL/9M/v3T4WvdhTjhkDJ8+ormdMVDdWgV3yz9D0
	Vr0OHAx/+gu1tfSJUQDjrQ
X-Received: by 2002:a4a:e90b:0:b0:6cd:3fdb:fa69 with SMTP id 006d021491bc7-716e7abb984mr618965eaf.84.1793915395917;
        Thu, 05 Nov 2026 13:49:55 -0800 (PST)
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com. [209.85.210.54])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4ad979eba0bsm436226fac.10.2026.11.05.13.49.55
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 13:49:55 -0800 (PST)
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-823e4047037so38235a34.2
        for <linux-hardening@vger.kernel.org>; Thu, 05 Nov 2026 13:49:55 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBzFi1iJFsO9x+yY6YqSxKr2O2Wr05f8DQoHI0VMSFxj6o8+zNAL4+KttpY71j02zdv1IEWKBBj1dFgrmDxoec0=@vger.kernel.org
X-Received: by 2002:a05:6820:4d48:b0:70b:8831:8c5e with SMTP id
 006d021491bc7-716e79aa3abmr562272eaf.51.1793915091517; Thu, 05 Nov 2026
 13:44:51 -0800 (PST)
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260925-brcm4388-submit-v1-0-b5cbc2cde2fb@gmail.com>
 <CAEg-Je918POdPr-=6Dzpdkx_i+Hv4wxv5-8A3MUDEqC8SA59NA@mail.gmail.com> <1a19d3270b8.2873.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <1a19d3270b8.2873.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
From: Neal Gompa <neal@gompa.dev>
Date: Thu, 5 Nov 2026 16:44:14 -0500
X-Gmail-Original-Message-ID: <CAEg-Je_xkZ1oGsg=uPtCT-Eh8_-TuLEwxEx02BfLiOB2bZyg-Q@mail.gmail.com>
X-Gm-Features: AclHuK92anjNPVWCBzaMzrlLgp2aPs-ERNpv9JXE7UUqwrJIWMbDdlGrpwi1rH4
Message-ID: <CAEg-Je_xkZ1oGsg=uPtCT-Eh8_-TuLEwxEx02BfLiOB2bZyg-Q@mail.gmail.com>
Subject: Re: [PATCH 00/13] wifi: brcmfmac: Add BCM4388 support
To: Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: michael.reeves077@gmail.com, Pieter-Paul Giesberts <pieterpg@broadcom.com>, 
	"Franky Lin (Zhenhui)" <frankyl@broadcom.com>, Mathy Vanhoef <vanhoefm@gmail.com>, Kalle Valo <kvalo@kernel.org>, 
	Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-wireless@vger.kernel.org, 
	brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com, 
	asahi@lists.linux.dev, Hector Martin <marcan@marcan.st>, 
	Daniel Berlin <dberlin@dberlin.org>, Janne Grunau <j@jannau.net>, linux-kernel@vger.kernel.org, 
	Hante Meuleman <meuleman@broadcom.com>, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 2, 2026 at 11:58=E2=80=AFAM Arend van Spriel
<arend.vanspriel@broadcom.com> wrote:
>
> Op 2 november 2026 01:43:07 schreef Neal Gompa <neal@gompa.dev>:
>
> > On Fri, Sep 25, 2026 at 9:49=E2=80=AFAM Michael Reeves via B4 Relay
> > <devnull+michael.reeves077.gmail.com@kernel.org> wrote:
> >>
> >> The Broadcom BCM4388 chipset requires new PCIe initialization and
> >> firmware interfaces. Add support for these interfaces to brcmfmac to
> >> enable basic station operation.
> >>
> >> This series adds:
> >> - Signed firmware loading and mailbox transport
> >> - Fixes for chip identification and firmware capability matching
> >> - Versioned scan and join requests, and extended PMK payloads
> >> - Updated event mask handling
> >>
> >> These changes include work by Hector Martin and Daniel Berlin from Asa=
hi
> >> Linux, refactored where needed for upstream inclusion.
> >>
> >> The series provides basic station support only. 6 GHz support is plann=
ed
> >> for a follow-up patchset after this lands. The driver retains legacy
> >> interfaces for older firmware.
> >>
> >> Tested on an Apple M3 MacBook Air (J613):
> >> - Device boot and network scanning
> >> - 5 GHz WPA2-PSK association and DHCP
> >> - Bidirectional TCP traffic
> >>
> >> Testing required separate Apple PCIe and devicetree patches, as well a=
s
> >> Janne Grunau's port-authorization fix [1].
> >>
> >> [1]
> >> https://lore.kernel.org/linux-wireless/20260915-brcmfmac-4way-handshak=
e-offload-authenticated-event-v2-1-fbb9cc7ac177@jannau.net/
> >>
> >> ---
> >> Daniel Berlin (1):
> >> wifi: brcmfmac: Support versioned scan parameter layouts
> >>
> >> Hector Martin (6):
> >> wifi: brcmfmac: Support newer PCIe core startup and interrupts
> >> wifi: brcmfmac: Negotiate PCIe mailbox transport with firmware
> >> wifi: brcmfmac: Load signed PCIe firmware images
> >> wifi: brcmfmac: Accept newer BSS information versions
> >> wifi: brcmfmac: Support versioned join requests
> >> wifi: brcmfmac: Add BCM4388 support
> >>
> >> Michael Reeves (6):
> >> wifi: brcmfmac: pcie: Report the detected chip ID to the bus
> >> wifi: brcmfmac: Match complete firmware capability names
> >> wifi: brcmfmac: Fall back to RSSI-only default join preferences
> >> wifi: brcmfmac: Use event_msgs_ext for event masks
> >> wifi: brcmfmac: Handle larger firmware band lists
> >> wifi: brcmfmac: Handle extended PMK command payloads
> >>
> >> .../wireless/broadcom/brcm80211/brcmfmac/Makefile  |   1 +
> >> .../net/wireless/broadcom/brcm80211/brcmfmac/bus.h |   9 +
> >> .../broadcom/brcm80211/brcmfmac/cfg80211.c         | 368 +++++++------=
-
> >> .../wireless/broadcom/brcm80211/brcmfmac/chip.c    |  36 +-
> >> .../wireless/broadcom/brcm80211/brcmfmac/common.c  |  27 +-
> >> .../wireless/broadcom/brcm80211/brcmfmac/core.c    |   5 +-
> >> .../wireless/broadcom/brcm80211/brcmfmac/core.h    |  18 +
> >> .../wireless/broadcom/brcm80211/brcmfmac/feature.c | 124 ++++-
> >> .../wireless/broadcom/brcm80211/brcmfmac/feature.h |   2 +
> >> .../wireless/broadcom/brcm80211/brcmfmac/fweh.c    | 130 ++++-
> >> .../wireless/broadcom/brcm80211/brcmfmac/fweh.h    |   1 +
> >> .../broadcom/brcm80211/brcmfmac/fwil_types.h       | 141 +++++-
> >> .../wireless/broadcom/brcm80211/brcmfmac/msgbuf.c  |  65 ++-
> >> .../wireless/broadcom/brcm80211/brcmfmac/msgbuf.h  |   9 +-
> >> .../wireless/broadcom/brcm80211/brcmfmac/pcie.c    | 560 +++++++++++++=
++++----
> >> .../broadcom/brcm80211/brcmfmac/scan_param.c       | 416 +++++++++++++=
++
> >> .../broadcom/brcm80211/brcmfmac/scan_param.h       |  13 +
> >> .../broadcom/brcm80211/include/brcm_hw_ids.h       |   2 +
> >> .../broadcom/brcm80211/include/chipcommon.h        |   5 +
> >> 19 files changed, 1593 insertions(+), 339 deletions(-)
> >> ---
> >> base-commit: 42a9fb3382fc2573e92f41d203b095d9a372cfc9
> >> change-id: 20260925-brcm4388-submit-5cb8d3e6d6a5
> >
> > Works for me and looks good.
>
> So what does "Works for me" mean here. Did you verify it is working on so=
me
> hardware you have? If so, please share the info.
>

Sorry, I have tested on a 14" M1 Pro MacBook Pro and a 14" M2 Max MacBook P=
ro.



--
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!
