Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B323E3145;
	Wed, 25 Mar 2026 15:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774452989; cv=none; b=VIE5guQEnP6VnUQUfw4ki9ZyEOITB+NckScZQPRHIQqPSqfTv9pnr+TPtGRKpwVorCz7gI8aMXXYJuoB9d9Wb8OuNzpUnjvRl6pah+YlXadpc9k4FWj0lZ8UNzgJOQFo1q9y1S7AeyxuirBXfzi7t+qGfL/QA/UaRzJmlD4MJz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774452989; c=relaxed/simple;
	bh=afxK29XT7z6lOZu36RAWnHYsA48pS6FMZa5Pft0e2Cg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AL8dVoAz3MmeWt3oGXllLo0fjr3LuP3ru+BioGreNipaEvX7npqH3uJbKEZoTTy26pdk0A1tjApxR1dJBfpvhoOceClTyPi7xfRLQ++MTXiFDY9mlTI8XhZ+0ukS5tQhFAVE01AjLZHW/RZdCPoWZq3oDmEJlg0+3dO+zpQ7HNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WFMYlLJv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WFMYlLJv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D599C116C6;
	Wed, 25 Mar 2026 15:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774452989;
	bh=afxK29XT7z6lOZu36RAWnHYsA48pS6FMZa5Pft0e2Cg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WFMYlLJvtpkgZe582ZNHqfpXP5FWrsnwIeBdVA0CfDXJOAyjxqxVpkAiHFK90tvPH
	 2tQlqHL6FuKnGcxYcUEG5bfDcKwsU9XzruoHF7ZOapfAO+TV1SGyr4nZW1bwLoEWAT
	 q5xq9rl7zy6p5u5HnXdhsvpvbGrZgHuzZVft1/RewtTjNQB82oSm3GagYiGzEXjMJN
	 rBqd1ufPw7TLmtJIIJi/Vjm96FxET2DnrdUjnAs4CTTnDexmgmDp4OF0K/GbPrk/mV
	 BLsHKDVRsFuLHMq2VlgL4NQgEmUu2wvlSq3kR0jew/ow2XnpaIEjG2KyojWVVi3zLs
	 DayeV8fxnwedw==
Date: Wed, 25 Mar 2026 10:36:28 -0500
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
Message-ID: <20260325153628.GA1189053@bhelgaas>
References: <acJYJlm2JZn_W7yO@M5403NF6WD>
 <20260324161533.GA1131495@bhelgaas>
 <DHBTY4W21Z9S.1LCIGKKJ0WX3T@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DHBTY4W21Z9S.1LCIGKKJ0WX3T@nvidia.com>

On Wed, Mar 25, 2026 at 07:34:50PM +0800, Kai-Heng Feng wrote:
> On Wed Mar 25, 2026 at 12:15 AM CST, Bjorn Helgaas wrote:
> > On Tue, Mar 24, 2026 at 05:33:06PM +0800, Kai-Heng Feng wrote:
> >> On 2026-03-20 09:52, Bjorn Helgaas wrote:
> >> > On Thu, Mar 19, 2026 at 07:13:09PM +0800, Kai-Heng Feng wrote:
> >> > > Add support for decoding NVIDIA-specific CPER sections delivered via
> >> > > the APEI GHES vendor record notifier chain. NVIDIA hardware generates
> >> > > vendor-specific CPER sections containing error signatures and diagnostic
> >> > > register dumps. This implementation registers a notifier_block with the
> >> > > GHES vendor record notifier and decodes these sections, printing error
> >> > > details via dev_info().
> >> > >
> >> > > The driver binds to ACPI device NVDA2012, present on NVIDIA server
> >> > > platforms. The NVIDIA CPER section contains a fixed header with error
> >> > > metadata (signature, error type, severity, socket) followed by
> >> > > variable-length register address-value pairs for hardware diagnostics.
> >> > >
> >> > > This work is based on libcper [0].
> >> > >
> >> > > Example output:
> >> > > nvidia-ghes NVDA2012:00: NVIDIA CPER section, error_data_length: 544
> >> > > nvidia-ghes NVDA2012:00: signature: CMET-INFO
> >> > > nvidia-ghes NVDA2012:00: error_type: 0
> >> > > nvidia-ghes NVDA2012:00: error_instance: 0
> >> > > nvidia-ghes NVDA2012:00: severity: 3
> >> > > nvidia-ghes NVDA2012:00: socket: 0
> >> > > nvidia-ghes NVDA2012:00: number_regs: 32
> >> > > nvidia-ghes NVDA2012:00: instance_base: 0x0000000000000000
> >> > > nvidia-ghes NVDA2012:00: register[0]: address=0x8000000100000000 value=0x0000000100000000
> >> >
> >> > Is there a convenient way to connect NVDA2012:00 with the actual
> >> > device?  I assume this is typically a PCIe device?  How would we
> >> > relate this with PCIe errors?
> >>
> >> The CPER report is from ARM RAS firmware and not neccessarily be
> >> related to a PCIe device.
> >
> > Right, I know CPER is more general than just PCI/PCIe.
> >
> > But in this case, I think NVDA2012 probably *is* a PCIe device.  How
> > would we figure out which one?  If we have to manually do an acpidump,
> > figure out which NVDA2012 is :00, and look for an _ADR or something,
> > that doesn't really seem convenient for multi-NVDA2012 situations.
> 
> It's actually just an ACPI device:
> Device (CPER)
> {
>   Name (_HID, "NVDA2012")  // _HID: Hardware ID
>   Name (_UID, 0x00)  // _UID: Unique ID
>   Method (_DSM, 4, Serialized) // _DSM: Device-Specific Method
> }
> 
> And that's it.

Weird.  There's nothing for a driver to operate the device with except
_DSM?  The device doesn't need any MMIO resources?  I would expect some
resources described by a _CRS method or some native enumeration protocol
like PCI BARs.

The _UID 0x00 matches the "00" in "NVDA2012:00", but I think that's a
coincidence; I think the "00" in the device name came from the ida_alloc()
in acpi_device_set_name(), not from _UID.

So I still don't know how you would identify the correct part in a system
with multiple NVDA2012 devices.  I do see the "socket" and "instance_base"
in the output.  Maybe that would help, but those seem to be
device-specific, and it seems like we should have a generic mechanism.
