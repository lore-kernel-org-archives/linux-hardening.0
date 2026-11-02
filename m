Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793580188;
	b=a7aacwYSZ4gMMAsRVP9YlTx3wxuKQw4RJni77beqJ8x8drMH9AKUgNBxWIP+TuYYj8y3
	 +wZ3P7X+nQ22rtxFQpGESvAlgccvHoG0+Vo6Hzz29oOyjoY/4RATGTabVtN+TClVts5uh
	 /ArVqJe7WUvwkVcDj8XcTJAY2n9g3Hzo9vDiaDdbraKytLdeyDts8KbKlKtaiAtfy/j1J
	 tS1wilKqz3PAsh51P9mLn2ebyZZ/+5xvdBbOmqt6p2hfKZPwYlkg9B8c+wYgxvlhCUDFk
	 m7eXB/VIjtgJ0zPgWflZZW68oIpu+pgXK/Y9GefVj0xazdQumTlLZfuWgPbH84tHlSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793580188;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=AxLijxCHhlhY2faPDuw/HBU0+yy89FEV9COVq1aaz44=;
	b=4XL01htnSokzTMB/Bl3+VsL466IbHCajakHkXY6osrW3YDDidayOwcAPGI49l5RtH+fI
	 P2pdCsj01fePTuzNaHwoDrE+WhT+Dp1aPI5p5yJ4gICGlXpxN95Xi7TuFBekqIh7ZkOW1
	 xIYG7mWvPJfuAUvZtco4QjHC7m9ZeigDRL9ZjtNF8R2zxd9ZfncCZbSOX95rpPx0hWlVq
	 xu5Ii+caU5zcgs0pDNdOiHJ8oYEtIBwQ2PWiPLkEEmHVh3qrrKKIgMNr7YkSwBmNuufNR
	 E4M2l33ESJjijwaWG2D6Mum7aQKxFLuj1+FB20j/J2oqxvmlkDT3N6u2VqyESNZbATA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gompa.dev;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.167.173
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20AA4606A32F
	for <linux-hardening@vger.kernel.org>; Mon,  2 Nov 2026 00:43:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 20AA4606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-56431524c22so291921b6e.0
        for <linux-hardening@vger.kernel.org>; Sun, 01 Nov 2026 16:43:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793580187; x=1794184987;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AxLijxCHhlhY2faPDuw/HBU0+yy89FEV9COVq1aaz44=;
        b=P8spwIjDuJLPaYmr47LS51HSKpLWyvOYnn4Xnovtppac2lvLManPn9UnirtwMqNvQ+
         Gzq73MUNjMGb1s1FySslpykQX+GotmUXQw+sVqK3ZLa3dcs5IDR7QxAh3EuZMTfh/ErT
         dTBM4CjKxgtR06Ww+qUKrBnL1Cy8MJHpLRzhokJAK+gBi8g5mUNXJmF0BnqOq/jsgaQi
         7NBRjBT6RPrtFUwbvSPBnFWIl6Bjna4A7CcuzAe6F+bxGCi6fDvPtWaQauCHU2xv6MVE
         1kyze9+XrI6RJHRowqj2ZbdF6thtISX6BD/XPlU81Mz+9u34FSk/KcB+9qozatep/Ijm
         MC0w==
X-Forwarded-Encrypted: i=1; AKwUvBxo9kDHHqrbGnZ3zsw1rOtGDoWlNlUpO/AG8T8WtJ+eFTAT5CE4rbqn8XntU2EWez6GaD17WV4+ZMxrOSK1iaE=@vger.kernel.org
X-Gm-Message-State: AFq9FYLVyzuqdpDdvdH3nh7B5BhmYjeiDAL0+cWOgomSXxFDu4rVANiw
	MZz2wWv25jY8s5T6u2qj8CIj5XlmyWy4FsboYAXHv/V81LBQ6/+uedqhPK0NhlBW
X-Gm-Gg: AYBFou0zvJ65WcdX3tHMPdPuLToLlHkSwkcv/nvlSyz2C6+WlEvCOno87j/ICDlqdFM
	9Cv3nSzQqiR2Gcdv6ZM8OOPCL42KX20vuYlbue8fhLzLXZtQtHU6oZCqUwiQy67t6antBgVPekR
	JeB3uDWv+3f65p/sD3tsxrFEm/zx/0o6MD6vVXiEk/1o5mEwGRfGYDRr+i8gUoPrDewyKxR8j8f
	246xhqBQ+GSOq/k9KnvD4S45Unu0pg2EzrVdNxhtuzLfuWaQZ5xAl8irkEb6EFrMSaHUEDJYQCi
	WCidjZOOhrWS4hexLtlQV9G3mOKJu7lzZY1eQER4FYXmFDhm1gi4d1HD53rUTCYsY9BiKcqIOTH
	1y2H1HkyAnIAbtF1NFotiDKwpj3LvRt65C17X1idShc/Hh+VR7Y16ANO2ZLLdwoOpDuIEr945Rp
	cGfYYQtrOztbCOuOyi1erpMQyBAw1BWD1CRBvunJQ5X9bZ5kHE+SahyxRqzHVtG8rD9ooOmO3mD
	vpfIps3e4vqCt2qTBE6rSZubOOcXQPGD9vtyEaraD+0mGekyDjE5RlmHQQbaYF6oDuZVt+2RrFw
	12cn2pj+jgISVVfnQSACt2tYRqvBIm++sc21pCamuXtMFMSQA4sxI/B0d6L2ljwiyQz9caB/Jai
	XjGdjWbIzpiIihAyMWkCFptd4PiV8RmqDgGiwbJbde3K6OQEtdEY0l65cFvW/VO54jzFPqN4Da6
	k=
X-Received: by 2002:a05:6808:30a7:b0:55b:f88d:6e8b with SMTP id 5614622812f47-5640dce892bmr6342588b6e.13.1793580186616;
        Sun, 01 Nov 2026 16:43:06 -0800 (PST)
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com. [209.85.210.47])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-5640fd95562sm6758201b6e.4.2026.11.01.16.43.05
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Nov 2026 16:43:05 -0800 (PST)
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-82109f51565so1138757a34.2
        for <linux-hardening@vger.kernel.org>; Sun, 01 Nov 2026 16:43:05 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBw+cZqa+CIImmKoQQmntrc0pBt9WFOQ0v9UNNLMInQn10yPWCj+51gNXHWy8eVXSnFlf/8bUb+devaIfMFXFcs=@vger.kernel.org
X-Received: by 2002:a05:6830:3e03:b0:814:b62d:3122 with SMTP id
 46e09a7af769-85d365b1f81mr6135908a34.22.1793580185285; Sun, 01 Nov 2026
 16:43:05 -0800 (PST)
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
In-Reply-To: <20260925-brcm4388-submit-v1-0-b5cbc2cde2fb@gmail.com>
From: Neal Gompa <neal@gompa.dev>
Date: Sun, 1 Nov 2026 19:42:28 -0500
X-Gmail-Original-Message-ID: <CAEg-Je918POdPr-=6Dzpdkx_i+Hv4wxv5-8A3MUDEqC8SA59NA@mail.gmail.com>
X-Gm-Features: AclHuK_r7QD-EGzh5icdkxVPJ8YDU4Pcq4HDNCl7O8hh8I3jnfCORQFhQybBRTw
Message-ID: <CAEg-Je918POdPr-=6Dzpdkx_i+Hv4wxv5-8A3MUDEqC8SA59NA@mail.gmail.com>
Subject: Re: [PATCH 00/13] wifi: brcmfmac: Add BCM4388 support
To: michael.reeves077@gmail.com
Cc: Arend van Spriel <arend.vanspriel@broadcom.com>, 
	Pieter-Paul Giesberts <pieterpg@broadcom.com>, "Franky Lin (Zhenhui)" <frankyl@broadcom.com>, 
	Mathy Vanhoef <vanhoefm@gmail.com>, Kalle Valo <kvalo@kernel.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-wireless@vger.kernel.org, 
	brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com, 
	asahi@lists.linux.dev, Hector Martin <marcan@marcan.st>, 
	Daniel Berlin <dberlin@dberlin.org>, Janne Grunau <j@jannau.net>, linux-kernel@vger.kernel.org, 
	Hante Meuleman <meuleman@broadcom.com>, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 25, 2026 at 9:49=E2=80=AFAM Michael Reeves via B4 Relay
<devnull+michael.reeves077.gmail.com@kernel.org> wrote:
>
> The Broadcom BCM4388 chipset requires new PCIe initialization and
> firmware interfaces. Add support for these interfaces to brcmfmac to
> enable basic station operation.
>
> This series adds:
> - Signed firmware loading and mailbox transport
> - Fixes for chip identification and firmware capability matching
> - Versioned scan and join requests, and extended PMK payloads
> - Updated event mask handling
>
> These changes include work by Hector Martin and Daniel Berlin from Asahi
> Linux, refactored where needed for upstream inclusion.
>
> The series provides basic station support only. 6 GHz support is planned
> for a follow-up patchset after this lands. The driver retains legacy
> interfaces for older firmware.
>
> Tested on an Apple M3 MacBook Air (J613):
> - Device boot and network scanning
> - 5 GHz WPA2-PSK association and DHCP
> - Bidirectional TCP traffic
>
> Testing required separate Apple PCIe and devicetree patches, as well as
> Janne Grunau's port-authorization fix [1].
>
> [1] https://lore.kernel.org/linux-wireless/20260915-brcmfmac-4way-handsha=
ke-offload-authenticated-event-v2-1-fbb9cc7ac177@jannau.net/
>
> ---
> Daniel Berlin (1):
>       wifi: brcmfmac: Support versioned scan parameter layouts
>
> Hector Martin (6):
>       wifi: brcmfmac: Support newer PCIe core startup and interrupts
>       wifi: brcmfmac: Negotiate PCIe mailbox transport with firmware
>       wifi: brcmfmac: Load signed PCIe firmware images
>       wifi: brcmfmac: Accept newer BSS information versions
>       wifi: brcmfmac: Support versioned join requests
>       wifi: brcmfmac: Add BCM4388 support
>
> Michael Reeves (6):
>       wifi: brcmfmac: pcie: Report the detected chip ID to the bus
>       wifi: brcmfmac: Match complete firmware capability names
>       wifi: brcmfmac: Fall back to RSSI-only default join preferences
>       wifi: brcmfmac: Use event_msgs_ext for event masks
>       wifi: brcmfmac: Handle larger firmware band lists
>       wifi: brcmfmac: Handle extended PMK command payloads
>
>  .../wireless/broadcom/brcm80211/brcmfmac/Makefile  |   1 +
>  .../net/wireless/broadcom/brcm80211/brcmfmac/bus.h |   9 +
>  .../broadcom/brcm80211/brcmfmac/cfg80211.c         | 368 +++++++-------
>  .../wireless/broadcom/brcm80211/brcmfmac/chip.c    |  36 +-
>  .../wireless/broadcom/brcm80211/brcmfmac/common.c  |  27 +-
>  .../wireless/broadcom/brcm80211/brcmfmac/core.c    |   5 +-
>  .../wireless/broadcom/brcm80211/brcmfmac/core.h    |  18 +
>  .../wireless/broadcom/brcm80211/brcmfmac/feature.c | 124 ++++-
>  .../wireless/broadcom/brcm80211/brcmfmac/feature.h |   2 +
>  .../wireless/broadcom/brcm80211/brcmfmac/fweh.c    | 130 ++++-
>  .../wireless/broadcom/brcm80211/brcmfmac/fweh.h    |   1 +
>  .../broadcom/brcm80211/brcmfmac/fwil_types.h       | 141 +++++-
>  .../wireless/broadcom/brcm80211/brcmfmac/msgbuf.c  |  65 ++-
>  .../wireless/broadcom/brcm80211/brcmfmac/msgbuf.h  |   9 +-
>  .../wireless/broadcom/brcm80211/brcmfmac/pcie.c    | 560 +++++++++++++++=
++----
>  .../broadcom/brcm80211/brcmfmac/scan_param.c       | 416 +++++++++++++++
>  .../broadcom/brcm80211/brcmfmac/scan_param.h       |  13 +
>  .../broadcom/brcm80211/include/brcm_hw_ids.h       |   2 +
>  .../broadcom/brcm80211/include/chipcommon.h        |   5 +
>  19 files changed, 1593 insertions(+), 339 deletions(-)
> ---
> base-commit: 42a9fb3382fc2573e92f41d203b095d9a372cfc9
> change-id: 20260925-brcm4388-submit-5cb8d3e6d6a5
>

Works for me and looks good.

Reviewed-by: Neal Gompa <neal@gompa.dev>


--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!
