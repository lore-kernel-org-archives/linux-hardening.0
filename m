Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B326218EB1;
	Tue, 24 Mar 2026 16:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774368935; cv=none; b=VwYZYGFRBh+nliG4V5Da/iPerEWewtQioxhnGfDT+G8dRYmxQKQ8atdUVSvs11l/XImF88efUcGU2FnEKXFustMFwiIZmhWDsYGUxXXRYQTDz0u2jABHR2lULWtRQkkHP6GTKWH3BHT4823CPZvzYg7hTLfujTMIRzCRbSXr0Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774368935; c=relaxed/simple;
	bh=xYE0WPxGCBWCOSXP82sjBN3xLQsRopgunx9uuNc1mOA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=fp1xmk3NZwJ45ZsGQTjkIHuz3V7jh28xVphWXNv2vnVxpXyVT1r+NUWfrGlo14BdE9mp6bPckxOQrOFD6Ito+IS0jAnYZzecoJcBr2T3mMmXpdjri0wXQ5a16r0LZAE0N/ylMnA11YikW7KD3+5pO7DTkAINwxJyLnpPAwuS/qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UD3bMMR4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UD3bMMR4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 211BCC19424;
	Tue, 24 Mar 2026 16:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774368935;
	bh=xYE0WPxGCBWCOSXP82sjBN3xLQsRopgunx9uuNc1mOA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=UD3bMMR4E0/hBoEM2t8dCmtJA4Il2ksi4i/umB8/w7/08T1uZu1BaO5daJlpLhwpv
	 mlA+a9ZT7A+SU9xgo9z7Phd18n1EAiABv/Auwoiw6G4K2EyoDKp67TPpMNJM0haJUw
	 St4N1SCwlQQSbQSOl1YbVk4kas+xmckOk4SmOII2iDr5ddOb6A1leRwR+PFijV/Ia3
	 J+kPopFzwA6JhlvhUqZvYXV79nkFFdcosE6NyXTDvZutRocpjPjbLONjw8iL9wyNof
	 GCGxFKZD3fwyxMYO90TT65IZ4PFf/AD1OVZPwNTi/ZT/LEIn5TwwV27V3VxpbWkMSN
	 2yljhrEGBU72w==
Date: Tue, 24 Mar 2026 11:15:33 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Kai-Heng Feng <kaihengf@nvidia.com>
Cc: rafael@kernel.org, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Shiju Jose <shiju.jose@huawei.com>, Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>, Hanjun Guo <guohanjun@huawei.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Shuai Xue <xueshuai@linux.alibaba.com>, Len Brown <lenb@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Will Deacon <will@kernel.org>,
	Huang Yiwei <quic_hyiwei@quicinc.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Nathan Chancellor <nathan@kernel.org>,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 3/3] acpi/apei: Add NVIDIA GHES vendor CPER record
 handler
Message-ID: <20260324161533.GA1131495@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acJYJlm2JZn_W7yO@M5403NF6WD>

On Tue, Mar 24, 2026 at 05:33:06PM +0800, Kai-Heng Feng wrote:
> On 2026-03-20 09:52, Bjorn Helgaas wrote:
> > On Thu, Mar 19, 2026 at 07:13:09PM +0800, Kai-Heng Feng wrote:
> > > Add support for decoding NVIDIA-specific CPER sections delivered via
> > > the APEI GHES vendor record notifier chain. NVIDIA hardware generates
> > > vendor-specific CPER sections containing error signatures and diagnostic
> > > register dumps. This implementation registers a notifier_block with the
> > > GHES vendor record notifier and decodes these sections, printing error
> > > details via dev_info().
> > >
> > > The driver binds to ACPI device NVDA2012, present on NVIDIA server
> > > platforms. The NVIDIA CPER section contains a fixed header with error
> > > metadata (signature, error type, severity, socket) followed by
> > > variable-length register address-value pairs for hardware diagnostics.
> > >
> > > This work is based on libcper [0].
> > >
> > > Example output:
> > > nvidia-ghes NVDA2012:00: NVIDIA CPER section, error_data_length: 544
> > > nvidia-ghes NVDA2012:00: signature: CMET-INFO
> > > nvidia-ghes NVDA2012:00: error_type: 0
> > > nvidia-ghes NVDA2012:00: error_instance: 0
> > > nvidia-ghes NVDA2012:00: severity: 3
> > > nvidia-ghes NVDA2012:00: socket: 0
> > > nvidia-ghes NVDA2012:00: number_regs: 32
> > > nvidia-ghes NVDA2012:00: instance_base: 0x0000000000000000
> > > nvidia-ghes NVDA2012:00: register[0]: address=0x8000000100000000 value=0x0000000100000000
> >
> > Is there a convenient way to connect NVDA2012:00 with the actual
> > device?  I assume this is typically a PCIe device?  How would we
> > relate this with PCIe errors?
> 
> The CPER report is from ARM RAS firmware and not neccessarily be
> related to a PCIe device.

Right, I know CPER is more general than just PCI/PCIe.

But in this case, I think NVDA2012 probably *is* a PCIe device.  How
would we figure out which one?  If we have to manually do an acpidump,
figure out which NVDA2012 is :00, and look for an _ADR or something,
that doesn't really seem convenient for multi-NVDA2012 situations.
