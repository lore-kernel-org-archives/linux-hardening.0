Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6FD63E3C4B;
	Wed, 25 Mar 2026 17:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774458495; cv=none; b=FnG7SlRNNcJK6xfQYr9qdoiW7pc4ds8NGT2+GyLia7Mb2GAuHsUXO2Vy3top60GuR9jht8uodC+jeOqe0QpajtGp8/WvbqpZNwvt0ArIvdkiz3zfxjsW/F2qtnLn7iDjlLkbrgonKmHPu8khBM1vp6Sfu4W9Veq8SuzIaCQh4C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774458495; c=relaxed/simple;
	bh=Wjf3K/wc7cDytRcGfYS5jhHKjfMoU+noHZ8vGYCvL1w=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GWD3mlu3iUkLBoiVK7VDwMXg46XCtKxKRqkvgX5gdLEQr57Fiyht1s27Qg8r3vRj5qQuW6hDDIDJJBHBjeo3pSGt6ne2S7Ik7Fst2yaAm5fkxlRfzLxEcHxk2Qi6FiCzNBWwUf4A4O00dLdyMrE/a+CQMt5up3ykqF7AGomKAt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fgtd20DjZzHnH52;
	Thu, 26 Mar 2026 01:07:34 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id B3F2140086;
	Thu, 26 Mar 2026 01:08:09 +0800 (CST)
Received: from localhost (10.48.157.17) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 25 Mar
 2026 17:08:08 +0000
Date: Wed, 25 Mar 2026 17:08:05 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: Kai-Heng Feng <kaihengf@nvidia.com>, <rafael@kernel.org>, Shiju Jose
	<shiju.jose@huawei.com>, Tony Luck <tony.luck@intel.com>, Borislav Petkov
	<bp@alien8.de>, Hanjun Guo <guohanjun@huawei.com>, Mauro Carvalho Chehab
	<mchehab@kernel.org>, Shuai Xue <xueshuai@linux.alibaba.com>, Len Brown
	<lenb@kernel.org>, Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva"
	<gustavoars@kernel.org>, Will Deacon <will@kernel.org>, Huang Yiwei
	<quic_hyiwei@quicinc.com>, Dave Jiang <dave.jiang@intel.com>, "Nathan
 Chancellor" <nathan@kernel.org>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] acpi/apei: Add NVIDIA GHES vendor CPER record
 handler
Message-ID: <20260325170805.00005ba1@huawei.com>
In-Reply-To: <20260325153628.GA1189053@bhelgaas>
References: <acJYJlm2JZn_W7yO@M5403NF6WD>
	<20260324161533.GA1131495@bhelgaas>
	<DHBTY4W21Z9S.1LCIGKKJ0WX3T@nvidia.com>
	<20260325153628.GA1189053@bhelgaas>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100011.china.huawei.com (7.191.174.247) To
 dubpeml500005.china.huawei.com (7.214.145.207)

On Wed, 25 Mar 2026 10:36:28 -0500
Bjorn Helgaas <helgaas@kernel.org> wrote:

> On Wed, Mar 25, 2026 at 07:34:50PM +0800, Kai-Heng Feng wrote:
> > On Wed Mar 25, 2026 at 12:15 AM CST, Bjorn Helgaas wrote:  
> > > On Tue, Mar 24, 2026 at 05:33:06PM +0800, Kai-Heng Feng wrote:  
> > >> On 2026-03-20 09:52, Bjorn Helgaas wrote:  
> > >> > On Thu, Mar 19, 2026 at 07:13:09PM +0800, Kai-Heng Feng wrote:  
> > >> > > Add support for decoding NVIDIA-specific CPER sections delivered via
> > >> > > the APEI GHES vendor record notifier chain. NVIDIA hardware generates
> > >> > > vendor-specific CPER sections containing error signatures and diagnostic
> > >> > > register dumps. This implementation registers a notifier_block with the
> > >> > > GHES vendor record notifier and decodes these sections, printing error
> > >> > > details via dev_info().
> > >> > >
> > >> > > The driver binds to ACPI device NVDA2012, present on NVIDIA server
> > >> > > platforms. The NVIDIA CPER section contains a fixed header with error
> > >> > > metadata (signature, error type, severity, socket) followed by
> > >> > > variable-length register address-value pairs for hardware diagnostics.
> > >> > >
> > >> > > This work is based on libcper [0].
> > >> > >
> > >> > > Example output:
> > >> > > nvidia-ghes NVDA2012:00: NVIDIA CPER section, error_data_length: 544
> > >> > > nvidia-ghes NVDA2012:00: signature: CMET-INFO
> > >> > > nvidia-ghes NVDA2012:00: error_type: 0
> > >> > > nvidia-ghes NVDA2012:00: error_instance: 0
> > >> > > nvidia-ghes NVDA2012:00: severity: 3
> > >> > > nvidia-ghes NVDA2012:00: socket: 0
> > >> > > nvidia-ghes NVDA2012:00: number_regs: 32
> > >> > > nvidia-ghes NVDA2012:00: instance_base: 0x0000000000000000
> > >> > > nvidia-ghes NVDA2012:00: register[0]: address=0x8000000100000000 value=0x0000000100000000  
> > >> >
> > >> > Is there a convenient way to connect NVDA2012:00 with the actual
> > >> > device?  I assume this is typically a PCIe device?  How would we
> > >> > relate this with PCIe errors?  
> > >>
> > >> The CPER report is from ARM RAS firmware and not neccessarily be
> > >> related to a PCIe device.  
> > >
> > > Right, I know CPER is more general than just PCI/PCIe.
> > >
> > > But in this case, I think NVDA2012 probably *is* a PCIe device.  How
> > > would we figure out which one?  If we have to manually do an acpidump,
> > > figure out which NVDA2012 is :00, and look for an _ADR or something,
> > > that doesn't really seem convenient for multi-NVDA2012 situations.  
> > 
> > It's actually just an ACPI device:
> > Device (CPER)
> > {
> >   Name (_HID, "NVDA2012")  // _HID: Hardware ID
> >   Name (_UID, 0x00)  // _UID: Unique ID
> >   Method (_DSM, 4, Serialized) // _DSM: Device-Specific Method
> > }
> > 
> > And that's it.  
> 
> Weird.  There's nothing for a driver to operate the device with except
> _DSM?  The device doesn't need any MMIO resources?  I would expect some
> resources described by a _CRS method or some native enumeration protocol
> like PCI BARs.
> 
> The _UID 0x00 matches the "00" in "NVDA2012:00", but I think that's a
> coincidence; I think the "00" in the device name came from the ida_alloc()
> in acpi_device_set_name(), not from _UID.
> 
> So I still don't know how you would identify the correct part in a system
> with multiple NVDA2012 devices.  I do see the "socket" and "instance_base"
> in the output.  Maybe that would help, but those seem to be
> device-specific, and it seems like we should have a generic mechanism.

It's not unique in ACPI terms.  There are a few cases even in the ACPI spec
of IDs that exist just to say some feature is there.

ACPI0017 is an example. Simply says, there be CXL here, go look for the
tables.

Here this device is used to indicate that a platform should be ready to handle
a particular type of error record.  If it happened to expose any other
interfaces, then I agree it would need resources or a _DSM etc.

Basically it's a workaround for the lack of discoverability in APEI /
ACPI error reporting. Could use an _OSC bit for the same job but then
we'd run out of those fast.  Device IDs are near free.

Jonathan


> 

