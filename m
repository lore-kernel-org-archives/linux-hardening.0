Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793282086;
	b=0s65U9C0fOkXIzqpMuikctlyijt9bK5axAL++aaikatacGLiHELhGI/KROr/7ktBmlRE
	 1AvFcZPo95pGVIDZw7bZYsxGMOsEeVDKXQPhF06dEnaX7MUdOA7B+ahKoDmlbLNJTks3o
	 SZavwXpSmpp5RSkzgkLy6pRRHcNtE12rsChA2WkcSTSC3XZwQUUe4SvG8OQ4Acwdc+N8a
	 w+xPp9W4+AEDtIaIBnvkGMMQSzGV6b9YJl4L3VmBoZ09jYW2p1BZWfLN5GAUtDxbDeVHI
	 1QgBL87H0cpMX29sUSVaPV0hEsR2Pha2iVxx8+2EdRwzwrI16s58F7dYe/vwP8+m9AA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793282086;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=9pamEexFG6/52egXa9hLLeSrQGqwFqspA1svbb9YVk4=;
	b=KuQqgIo6+5dyNldhD48kN4zO/ORQkC6mbZIKt25frVNyUnX/TDvH2gvta/zhyeUw4cD2
	 6U4A5PzhYA71qUvL1T0h/dIVjrVIYPYaQhKZlqrN2RJGFxM99Urr2fQlf96tJrWHg+Dwy
	 QNhX4p2hP50DjNHZMvCeK2YyW4G71ZTHg/TS1dj5OqehLrMwxCkRctDsBtdz3Ux27+gHk
	 IRv/TqwIhswaP4PILXMVUz+1fmWP4in179GI5Op0vrnSFMOlw0EzGzEXmscULkUNkDmQ6
	 b/koC/rKaT5Zk7OmeBxQzur2JyrICooGdA9BBe+xG2hXP/mbCokg6qNhmJOuhxLp+Jg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ga5NksAI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 341BD606A31A;
	Thu, 29 Oct 2026 13:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ga5NksAI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 646171F01825;
	Thu, 29 Oct 2026 13:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793282085;
	bh=9pamEexFG6/52egXa9hLLeSrQGqwFqspA1svbb9YVk4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Ga5NksAIKx9E5rhS+Wmw4j7v1i3706sDmtjVdgHnMsH2v6wWruI6K8kWZ47fD+PJV
	 d/onsiIsW3iX7h/LweN3yLS17eVB6bXCyL6OysbyDVnH/Et+Gks7S3syohiUZr9+5t
	 WZO3wDHX5VprTB4dRDeXExDyF5x3g1KPiOvHVrF5gzld7qZnbUc0xQqVZ+47ATNiFo
	 t6K6Fi+CNO49KUpE45Vr7qZ0n6zVQiPhlY6kGXm6hNxjSyCkBYxYASTJGa5MIUA0ih
	 4FJoUxBi6pnavShQf3DWPS92HlYoBagp+Eow+lxYmHOC5M9KbsdKmRUWxqn4bc+bxg
	 p7ag0S872AfiA==
Message-ID: <e3c9087e-fea5-4ec6-852a-a0e0e33ce461@kernel.org>
Date: Thu, 29 Oct 2026 14:54:35 +0100
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] dt-bindings: mfd: introduce the TC9564 config syscon
To: Alex Elder <elder@riscstar.com>, robh@kernel.org
Cc: sboyd@kernel.org, bmasney+clk@redhat.com, jbrunet+clk@baylibre.com,
 krzk+dt@kernel.org, conor+dt@kernel.org, lee@kernel.org,
 andersson@kernel.org, konradybcio@kernel.org, abelvesa@kernel.org,
 kees@kernel.org, gustavoars@kernel.org, p.zabel@pengutronix.de,
 daniel@riscstar.com, mohd.anwar@oss.qualcomm.com,
 lorenzo.bianconi@oss.qualcomm.com, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, mfd@lists.linux.dev,
 linux-arm-msm@vger.kernel.org, linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260918165234.687224-1-elder@riscstar.com>
 <20260918165234.687224-2-elder@riscstar.com>
 <20260920-fiery-fanatic-manticore-6abf0a@quoll>
 <85b0e7de-e4a8-4e08-b801-a9664d366e1a@riscstar.com>
 <7e32063f-f1a4-4259-96c9-fcbdd25c7f2f@riscstar.com>
 <fbeac5ba-a28d-4d34-8d23-4946aef515ea@kernel.org>
 <4bb9c85e-f991-484e-861f-1940b8263890@riscstar.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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
In-Reply-To: <4bb9c85e-f991-484e-861f-1940b8263890@riscstar.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 28/09/2026 16:52, Alex Elder wrote:
> On 9/23/26 2:25 AM, Krzysztof Kozlowski wrote:
>> I think nothing behind PCI EP should be described in DT, because
>> everything is internal to the device and implied by compatible (or
>> vid/pid). We do describe internals of devices in DT usually for complex
>> devices (like some display blocks with multiple subblocks) or when they
>> are used outside of that device. That's why I asked how are all these
>> clocks and resets exposed to the host. If the syscon is used only by the
>> device itself, I don't quite get the benefits of describing it in DT.
> 
> You say you think "nothing behind PCI EP should be described in DT".
> However the mere existence of the PCI endpoint bus as an option
> contradicts that statement, by providing a means of doing *exactly*
> that:  using devicetree to describe things behind a PCI endpoint.
> This is the model we are using.

No, the existence does not contradict. We allow further description as
long as things are not autodiscoverable and are necessary for the host
to deal with the device, like power sequencing. Same we did for
"onboard" USB hubs.

You are however describing internals of the device like syscon, which is
way beyond what is necessary for the host to instantiate that device.

> 
> In June we switched over to using the pci-ep-bus model based on a
> suggestion from Rob Herring (and Mani Sadhasivam).  Rob felt our
> previous auxiliary device approach wasn't right for the peripherals
> found within the SoC, given we were accessing them via PCI BARs.
>    https://lore.kernel.org/lkml/20260605144032.GA3659201-robh@kernel.org/

Oh, that's good, so let's quote:

"The ethernet nodes should be just these PCI function nodes."

"And really, a DT node for them should be completely optional (unless
there's some power on ctrl needed)."

"Everything else like SPI, GPIO, UART, etc. should be under the PCIe
switch upstream node in a pci-ep-bus."
Sure, but you add syscon. That's completely internal stuff.

> We found that using pci-ep-bus provided a very natural and familiar
> way of representing the organization of the TC9564 SoC, and used
> it to represent all of the peripherals (including XGMAC).  It
> nicely partitions the hardware design, as well as providing a
> well-understood connection with the software.
> 
> The switch involved quite a bit of work, and the result is a set
> of basically independent platform drivers that are modular and
> easily reviewed.  I really would rather not go back to to what
> we had before.
> 
> Do you have criteria for what in a chip/SoC is sufficiently
> "complex" to warrant allowing devicetree to describe some of
> its internal details?

For me criteria are the resources from the host. I think I said it
already, we do not describe internals of I2C or SPI devices: their
internal clocks, internal power supplies. We only describe the inputs
from the host. You can map it into the pins.

Same here, IMO.

> 
> I believe the TC9564 *is* such a "complex" SoC.  And in any case,
> anywhere pci-ep-bus is used, it implies that some chip internals
> would be described using devicetree.
> 
> Would incorporating the chip internals in a devicetree *overlay*
> have any effect on your opinion on this?  I.e., the "main"
> devicetree nodes would simply define the PCI device hierarchy,
> but anything behind an endpoint would be described in an overlay.
> This way, pci-ep-bus on a PCI endpoint just provides an external
> interface onto which a very complex device could be "mounted"
> (and described in an overlay).
> 
> I'd like to continue to move ahead with upstreaming support for
> this SoC, but to me it seems you have basic doubts about
> pci-ep-bus and I'd like to get past that.

Well, Rob might understand this better, so maybe review from him will
solve these questions.

Best regards,
Krzysztof
