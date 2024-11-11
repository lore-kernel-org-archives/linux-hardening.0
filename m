Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FBDC1BBBC5;
	Mon, 11 Nov 2024 21:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731360232; cv=none; b=ZCrmiXL9aISGNRhE2ZJGb8cbn7SlH58JQHpvrimzNPD01S/f62GpzrFhJsrgoKfayH1foNHoSsCfEMN+w6L/ML+mBqI23ax4Ie6Fi0tf3V61Jsq1YGbFii+D70WNK5QV130jlAM29bzZ5BT7drc6HXNLcX6JPpPrFWNQHubqe5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731360232; c=relaxed/simple;
	bh=NaCDGDciMwXtP8AUG1ZAj+h2gJO6t1bPaGcNDVapqAk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tZapendPQvE7EBi8VAn3lj7jNYSmFxd7Iq31iAeTSSqBaLz3evLr7idp543obh8SRZnKm8D/rnNmRCimOI9xtgGNM/I650jNkXo7rUkFSYF3UPhOT8uTJsZGQh3x+jE+6EOrDQhU1F2AjZIFkVJH1kzv3LV+sF1XeauLtPwL0F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UGeajZqh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UGeajZqh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A315C4CECF;
	Mon, 11 Nov 2024 21:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731360231;
	bh=NaCDGDciMwXtP8AUG1ZAj+h2gJO6t1bPaGcNDVapqAk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UGeajZqhjZasGKQm4q6r+WxsrNe2qCdR8p7pVfXpD/oW1Xy/qHoKXKF2ZVi7IlQEu
	 bQznd75PmHJeMy1KncMfKpBjPnUWuIW6E7HgY45LfIiGB6Kv5JD76iOhJyovUAejMq
	 NkgaEhkc6Y30Ax1HTcS1Zt5p1ubGbiory1TIjkjuqg8fW3AQ0HAlAEENZGfxpL9++c
	 qilmeCsNN/1EveDny5370zOPFT0Ke5NnLmoAA4XLloX4IaWqbkpJ61W7Kn3qUmE/q3
	 GNHKQV2ePkM5uhHrXDa4sgdWjj4Ifd3bWb1Bboe1IrcIBHPhIFKu+a0JGWnFNtNIZc
	 RV4xF8d6+swXQ==
Date: Mon, 11 Nov 2024 15:23:49 -0600
From: Rob Herring <robh@kernel.org>
To: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc: Conor Dooley <conor@kernel.org>, Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Felipe Balbi <balbi@kernel.org>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-hardening@vger.kernel.org, Devarsh Thakkar <devarsht@ti.com>,
	Hari Nagalla <hnagalla@ti.com>, linux@ew.tq-group.com
Subject: Re: [PATCH 2/5] dt-bindings: arm: ti: Add compatible for AM625-based
 TQMa62xx SOM family and carrier board
Message-ID: <20241111212349.GA1955710-robh@kernel.org>
References: <cover.1730299760.git.matthias.schiffer@ew.tq-group.com>
 <4f5ad877f44df35a3b2c7f336647f057c4e6377d.1730299760.git.matthias.schiffer@ew.tq-group.com>
 <20241104-floral-dexterous-7d3fee2ff616@spud>
 <c73cac598788ccabd1791b1232e8fd9d7ce23ac6.camel@ew.tq-group.com>
 <20241105-tinsmith-countable-fbb51045bc98@spud>
 <7286141141fe4930cd2581dac7a1fb36a98e62c4.camel@ew.tq-group.com>
 <20241106-happy-anything-46f7293f6aca@spud>
 <068c22af19c07a7c79bb4abb0366a2505b4b1aae.camel@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <068c22af19c07a7c79bb4abb0366a2505b4b1aae.camel@ew.tq-group.com>

On Mon, Nov 11, 2024 at 10:58:57AM +0100, Matthias Schiffer wrote:
> On Wed, 2024-11-06 at 16:40 +0000, Conor Dooley wrote:
> > On Wed, Nov 06, 2024 at 01:03:08PM +0100, Matthias Schiffer wrote:
> > > On Tue, 2024-11-05 at 18:55 +0000, Conor Dooley wrote:
> > > > On Tue, Nov 05, 2024 at 11:40:20AM +0100, Matthias Schiffer wrote:
> > > > > On Mon, 2024-11-04 at 18:47 +0000, Conor Dooley wrote:
> > > > > > On Mon, Nov 04, 2024 at 10:47:25AM +0100, Matthias Schiffer wrote:
> > > > > > > The TQMa62xx is a SoM family with a pluggable connector. The MBa62xx is
> > > > > > > the matching reference/starterkit carrier board.
> > > > > > 
> > > > > > Why all the wildcards? Why isn't there a compatible per device in the
> > > > > > family?
> > > 
> > > Because all variants use the same Device Tree. There is also only one compatible and one (main) DTSI
> > > for the AM62 SoC family, which our Device Trees are based on.
> > 
> > So what varies between the members of the family?
> 
> There are currently 6 SoCs in the family:
> - AM6254
> - AM6252
> - AM6251
> - AM6234
> - AM6232
> - AM6231
> 
> They differ in:
> - Existence of GPU (AM625 vs AM623)
> - Number of Cortex-A53 cores (last digit)
>  
> All of these use ti,am625 as their SoC-level compatible. The differences are currently handled by U-
> Boot, which checks various feature flags in the SoC registers and patches the OS DTB accordingly by
> removing CPU nodes and disabling the GPU node if necessary.

That's how it should be. Most likely, those are all the same die. 
Different die are expensive and it takes a high volume to justify the 
cost.

Rob
