Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EAB12E3707;
	Tue, 15 Jul 2025 10:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752574345; cv=none; b=uuLzOqWWPLY/f2QG8qc8hW1JqFDx9aGmcHKKIgx4Z5yMfV3kaYuWVPhyJhhr52QLMHoMhfEkH3iDaBmJvTadNlK7DVkN5mJTslFFwOT0Dm+SQlgtnCtI35t533dW2x90T0ouzqc+wx4hHW3+PnUBEc89OmWKnMAF9SHdLxoc1oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752574345; c=relaxed/simple;
	bh=D7wm1TkuxIcHGdRFpKYcPZ2w/5rOVloDtlG2dEqiY5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NBKe52gS1cdGJOlsPDSOM5q0xFK9LufZElyvo/Hl+2GdaDLn3Tt7gNNqbUFURkWx3kkFqbwcTqhU0Qxgl9JLfOyPOw3/F4sxrxchwjp7OH/Z0h2ChFxl8Ekh/c5H/9LYkTrLTSjRpqonEgY0JlH2uZ8VvJ2mXf5ADFsh/YNyQqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=mpXJODa+; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="mpXJODa+"
Received: by linux.microsoft.com (Postfix, from userid 1218)
	id BA454211CE04; Tue, 15 Jul 2025 03:12:23 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BA454211CE04
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1752574343;
	bh=IBp2TzY21ALyfQiEg4dCqn4g3cE1Zf0Z8i3I1ZAVMhw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mpXJODa+EZhuHyiB5CgkD94Xm9vAggVEyyzH5uTECBVfMgcmMSlU2g1+zW0u8PfiN
	 nHqatUyPfKe/H14kzs2qtAvt2ra5goFtZxp71lRh/XdFZ/JsTRUgjeg4Lx//Yq1AH8
	 2WMGO3IRF05Azmpcwr7Z9UGpmWlw6bOcmKvVgFWM=
Date: Tue, 15 Jul 2025 03:12:23 -0700
From: Abhishek Tiwari <abhitiwari@linux.microsoft.com>
To: Rob Herring <robh@kernel.org>
Cc: krzk+dt@kernel.org, conor+dt@kernel.org, kees@kernel.org,
	tony.luck@intel.com, gpiccoli@igalia.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, abhitiwari@microsoft.com
Subject: Re: [PATCH] dt-bindings: memory: Document linux,usable-memory
 property
Message-ID: <20250715101223.GA6320@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1741874545-19091-1-git-send-email-abhitiwari@linux.microsoft.com>
 <CAL_JsqKU8hE=dXdQ+hO0WvU-GuXAjEBgCPJ4rnxef9851zyKMw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_JsqKU8hE=dXdQ+hO0WvU-GuXAjEBgCPJ4rnxef9851zyKMw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Thu, Mar 13, 2025 at 01:57:30PM -0500, Rob Herring wrote:
> On Thu, Mar 13, 2025 at 9:03 AM Abhishek Tiwari
> <abhitiwari@linux.microsoft.com> wrote:
> >
> > Add Documentation for linux,usable-memory
> >
> > Signed-off-by: Abhishek Tiwari <abhitiwari@linux.microsoft.com>
> > ---
> >  .../bindings/linux,usable-memory.txt          | 32 +++++++++++++++++++
> >  1 file changed, 32 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/linux,usable-memory.txt
> >
> > diff --git a/Documentation/devicetree/bindings/linux,usable-memory.txt b/Documentation/devicetree/bindings/linux,usable-memory.txt
> > new file mode 100644
> > index 000000000000..167054d2e9a2
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/linux,usable-memory.txt
> > @@ -0,0 +1,32 @@
> > +linux,usable-memory
> > +===================
> 
> This belongs here:
> https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/memory.yaml
> 
> > +
> > +Description
> > +-----------
> > +The ``linux,usable-memory`` property can be used to restrict usable memory
> > +region. This property holds a base address and size, Memory outside of this
> > +range is not accessible by the kernel. This property is particularly useful
> > +in specialized hardware platforms where certain memory regions must be
> > +reserved for specific use.
> > +
> > +Common use cases include:
> > +- Allocating ``ramoops`` region
> > +- Reserving memory for hardware-specific needs
> > +- Fake Protecting persistent memory (PMEM)
> 
> All these examples belong in /reserved-memory nodes, not
> linux,usable-memory. Go see the ramoops binding for example.
> 
> This was really for the case where you already have 'reg' (in the
> memory node), but need to limit memory while at the same time not
> overwriting 'reg'. Basically, for kexec where you can keep booting
> another kernel forever. If that's not your usecase, you shouldn't be
> using this.
> 
> Rob

Thank you for your suggestions and explanations. I will update 
the definition and examples accordingly, and submit a PR with 
the documentation for this property in the specified repository.
