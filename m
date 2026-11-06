Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.216.248.207
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793989120;
	b=wQPNzexV2cZwwJGdsCfVFKf9GJaUBl/eJfBVQNDv5w79uXtb7K6sdQ2cd84qzRw2N7an
	 l2Ifq0rLDEHz7dUcgU8E6udPmJHSxNnXTyv3S+Axbf2E1qWYn2lPWvbOMhrB/hwXKPoJ/
	 wNKON0PTXSW6Onh+39EY/1dXE2hfLGHsuow+IT9/O7mEY+mjuGVRynu79dhNY5SCGrPhT
	 yqBWlM9e001hIfATUzepytVFxdhW3s9pjIx4G3tSI2gA6CKjNnZzFd+B3QlabiuxCYKX7
	 kGm7b3XPYIJ6lshTZlmBH5iX93G9wL8kev7Afe76Gzm7Y3CVMpRP25TYoNrtbet+5Jw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793989120;
	h=DMARC-Filter:Date:X-Lima-ML-UUID:DKIM-Signature:From:To:Cc:Subject:
	 Message-ID:In-Reply-To:References:Organization:X-Mailer:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=dyygcqcAN6zPeXsDXub4yWu3eaYgS8p+qfGLoA+tRmk=;
	b=AcTfUqURb/B63DVU4G8JSxhD1j42VNY6seb+fhTcbGiztRRlON3SB0ui+nTR5OfCgU9s
	 VVdXYVX1hWBBU8gM0EscW1Z9IEEPPlamFp6Yb6SUHJ08Q5VFh1Mp5D57sRfcVgRN7Rel/
	 7v4XIiErGcGrhOn7P3SqBP9J7VQNz3z3Nj9whVGxnDwT+HbU4OfBfP5NHaXG6uFocZBqv
	 ZKOQrbksBHvcx8n12MlenkYjTm9N1g89DAmDiNdQ5VMuEGQ1VNyE8anCD/UqrkVQLqtfE
	 87NWdpaXaeBP6yfEYTcYLkj+Otv1PEdx8snq+iUkp6KxTsaCeWakfejWG7gpi5J/thw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=deq.rocks;
	spf=none smtp.mailfrom=deq.rocks;
	arc=none smtp.remote-ip=91.216.248.207
Received: from mx5.mail-out.lima-city.de (mx5.mail-out.lima-city.de [91.216.248.207])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC43606A32C;
	Fri,  6 Nov 2026 18:18:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BCC43606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=deq.rocks
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=deq.rocks
Date: Fri, 6 Nov 2026 19:18:26 +0100
X-Lima-ML-UUID: 52e3c1d7-73c4-420c-837c-f7ae052149fb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=deq.rocks;
	s=securedbylima-20251205; t=1793989110;
	bh=QKKFbfCa9dHm2YxFOGcOT17+76twgyOoEkQPZtq3Y0Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ft3ZTQYazgHJy+WiOicPJcdpdkn0Av1qnb5U8ypS+7+NwSnstj3u5W5OQ7i+LxZcv
	 dqQv1FMGNoXEfpKUelayYiq5xLIAHld+EOG46Bdv9KCwyi4y2BbdD8K5VFM2MSCvqj
	 NcMr3O1JWGDe11wiVU6xi+r9l7CYoUFND5rtTkJ+i5q1KyfpjX6/M1Ou6XVPeWNs0/
	 g/+GYf3xTU9B4Z2Tfga6WhoIGJ+qEga6y3eA9BSB/uwIvF+6IRdpS9a0FA7KOanhpS
	 7iAFFMX3K2cT/KOSR42AOTyuyruQPTGOa7mWvgU2z6TzFH+0W1+XxRwoR8tAvzbXIN
	 flBdU7MnQin/Q==
From: =?UTF-8?B?QW5kcsOp?= Eikmeyer <dev@deq.rocks>
To: Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: <asahi@lists.linux.dev>, <brcm80211-dev-list.pdl@broadcom.com>,
 <brcm80211@lists.linux.dev>, <dberlin@dberlin.org>, <frankyl@broadcom.com>,
 <gustavoars@kernel.org>, <j@jannau.net>, <kees@kernel.org>,
 <kvalo@kernel.org>, <linux-hardening@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-wireless@vger.kernel.org>,
 <marcan@marcan.st>, <meuleman@broadcom.com>, <michael.reeves077@gmail.com>,
 <pieterpg@broadcom.com>, <vanhoefm@gmail.com>
Subject: Re: [PATCH 05/13] wifi: brcmfmac: Negotiate PCIe mailbox transport
 with firmware
Message-ID: <20261106191826.4ddb997a@kait2en-mbp15-1>
In-Reply-To: <1a1b1ef4b20.2873.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
References: <20261106153612.2aadef2a@kait2en-mbp15-1>
	<1a1b1ef4b20.2873.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
Organization: KaiT2en
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 06 Nov 2026 18:36:52 +0100
Arend van Spriel <arend.vanspriel@broadcom.com> wrote:

> Sorry, you lost me there. What is the relation between the patch in
> this subject and D3 ack.

Hi Arend,

D3_INFORM and D3_ACK are mailbox messages, and 05 changes how they are
exchanged. Without 05 brcmfmac writes D3_INFORM to the TCM mailbox
and our cursed Apple 4377 firmware on the 9,1 doesn't read it.

That is why I mentioned the D3 ACK timeout handling patch. I
submitted that because I was sure the firmware wouldn't send it.
But actually the transport was broken.

https://lore.kernel.org/all/20261001085308.1688049-1-dev@deq.rocks/

which was superseded by Sebastian's patch here:

https://lore.kernel.org/linux-wireless/20260915-brcmfmac-bcm43752-suspend-fix-v2-1-1bd84914998b@collabora.com/

So probably for addressing Sebastian's issue this needs to stay
anyways. My memory served me wrong. I just read that his device is not
an Apple product, but his patch incidentally worked around the same
problem. Sorry if i was causing unneccessary noise. 

Andre
