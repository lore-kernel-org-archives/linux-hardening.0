Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E793FE35D
	for <linux-hardening@vger.kernel.org>; Wed, 25 Mar 2026 17:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774458981; cv=none; b=foHUKarB0N3/MVww575pABXaO0qNw3vNiea7LC8BTKIWUgjKMmefUdyeLEBAfSrwYHaF1iGhAckH4u0SsnpkcUcA/T9WyEWQrNIneEvi324FtITD1Tz6mRBto5OmvWb8eqEXOOv+g37Y85uPQKPg1h6W/6OFsZfIVimpW0SYnbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774458981; c=relaxed/simple;
	bh=2hcKSsui5WBGqPDwcFVXgtU4A6cWRrjy69NusLHOeAQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rs5Cf75tOaBFxz4oVxGy3DqEAjlUzSO1e+InwSyIux4HS9g5jGL0aiAozEaXv+cJI+WnGZy9DayUC87Z29vcosUsd/BOmy43c0OFffDVvhPFdc71f2KB7p2qgva7g4qb8NHZPFxV8wsVlnC3Rz9bnNl9FbAKPuchWs3aSqk+JQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XrBdcsDB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XrBdcsDB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17D05C2BCB6
	for <linux-hardening@vger.kernel.org>; Wed, 25 Mar 2026 17:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774458981;
	bh=2hcKSsui5WBGqPDwcFVXgtU4A6cWRrjy69NusLHOeAQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=XrBdcsDBR/hRA28jDNz7mwJGjsF+bsHu2DpkTAf36uWRp8LWJLHp9Uvd4z0Z/VkdI
	 lVNvo2W+KyR8739nfLNTXdTnITvPKYebio0fPTDYiiuz+0ij0wNgBpF90w/U5d5MlX
	 BuLmdFpXP8Pm5J1Rn1wXJptSCLLMtI5XlqVLUSKt1tQ+fZtChJobl+8Fk4eQo70g1B
	 MNYb4RIoa1eVOZRV83GubD4chwM5VH19rVugzBt849e9bcRAjewObAmOHxy3EUs6UU
	 KSh6XWhTf7TXglNRYQxXp+eAUOB4Zj1JYAmVPpOnDDGHMKOkfp/eg8ZbEhGnoKQvgx
	 1ygbkZ0qvvamQ==
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-415c8a4d2e6so53734fac.0
        for <linux-hardening@vger.kernel.org>; Wed, 25 Mar 2026 10:16:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWxbdijlg5WxNpRRLTTeHaLpngt54NKdOgpT0JXUgX9f06EgyyLohe7S/HUBIgh5QFZZiCAhoMBrYpufkz6Dac=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywy5oBg/5jKaciEY12PNp7kw4KGoXpIcOwOLjdRxIRCeJ9QDNwF
	NrZNyxmIiRdKTvDpoqJpSxJTkn44Cjb1Tu/Tms8eD1spfaRZb7a0NhCyU/t6zAtqIZQf3zJFymd
	gU3Q489zRKRNwZbDzSA6EvfhsF+sS2x0=
X-Received: by 2002:a05:6870:8dc8:b0:417:2a17:285 with SMTP id
 586e51a60fabf-41ca7003846mr2323605fac.30.1774458979846; Wed, 25 Mar 2026
 10:16:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <acJYJlm2JZn_W7yO@M5403NF6WD> <20260324161533.GA1131495@bhelgaas>
 <DHBTY4W21Z9S.1LCIGKKJ0WX3T@nvidia.com> <20260325153628.GA1189053@bhelgaas> <20260325170805.00005ba1@huawei.com>
In-Reply-To: <20260325170805.00005ba1@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 25 Mar 2026 18:16:07 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hrvqVHutf27GXtA_wX5mDC=boq8z0kG570dhaX4tKZpw@mail.gmail.com>
X-Gm-Features: AQROBzDtKbsXPgGx_n7ggjHtefyZQ8wQVR0bsXcoGvoZ2DCEuDL9YyvxHOrDn5s
Message-ID: <CAJZ5v0hrvqVHutf27GXtA_wX5mDC=boq8z0kG570dhaX4tKZpw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] acpi/apei: Add NVIDIA GHES vendor CPER record handler
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Kai-Heng Feng <kaihengf@nvidia.com>, rafael@kernel.org, 
	Shiju Jose <shiju.jose@huawei.com>, Tony Luck <tony.luck@intel.com>, 
	Borislav Petkov <bp@alien8.de>, Hanjun Guo <guohanjun@huawei.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Shuai Xue <xueshuai@linux.alibaba.com>, 
	Len Brown <lenb@kernel.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Will Deacon <will@kernel.org>, 
	Huang Yiwei <quic_hyiwei@quicinc.com>, Dave Jiang <dave.jiang@intel.com>, 
	Nathan Chancellor <nathan@kernel.org>, 
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 25, 2026 at 6:08=E2=80=AFPM Jonathan Cameron
<jonathan.cameron@huawei.com> wrote:
>
> On Wed, 25 Mar 2026 10:36:28 -0500
> Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> > On Wed, Mar 25, 2026 at 07:34:50PM +0800, Kai-Heng Feng wrote:
> > > On Wed Mar 25, 2026 at 12:15 AM CST, Bjorn Helgaas wrote:
> > > > On Tue, Mar 24, 2026 at 05:33:06PM +0800, Kai-Heng Feng wrote:
> > > >> On 2026-03-20 09:52, Bjorn Helgaas wrote:
> > > >> > On Thu, Mar 19, 2026 at 07:13:09PM +0800, Kai-Heng Feng wrote:
> > > >> > > Add support for decoding NVIDIA-specific CPER sections deliver=
ed via
> > > >> > > the APEI GHES vendor record notifier chain. NVIDIA hardware ge=
nerates
> > > >> > > vendor-specific CPER sections containing error signatures and =
diagnostic
> > > >> > > register dumps. This implementation registers a notifier_block=
 with the
> > > >> > > GHES vendor record notifier and decodes these sections, printi=
ng error
> > > >> > > details via dev_info().
> > > >> > >
> > > >> > > The driver binds to ACPI device NVDA2012, present on NVIDIA se=
rver
> > > >> > > platforms. The NVIDIA CPER section contains a fixed header wit=
h error
> > > >> > > metadata (signature, error type, severity, socket) followed by
> > > >> > > variable-length register address-value pairs for hardware diag=
nostics.
> > > >> > >
> > > >> > > This work is based on libcper [0].
> > > >> > >
> > > >> > > Example output:
> > > >> > > nvidia-ghes NVDA2012:00: NVIDIA CPER section, error_data_lengt=
h: 544
> > > >> > > nvidia-ghes NVDA2012:00: signature: CMET-INFO
> > > >> > > nvidia-ghes NVDA2012:00: error_type: 0
> > > >> > > nvidia-ghes NVDA2012:00: error_instance: 0
> > > >> > > nvidia-ghes NVDA2012:00: severity: 3
> > > >> > > nvidia-ghes NVDA2012:00: socket: 0
> > > >> > > nvidia-ghes NVDA2012:00: number_regs: 32
> > > >> > > nvidia-ghes NVDA2012:00: instance_base: 0x0000000000000000
> > > >> > > nvidia-ghes NVDA2012:00: register[0]: address=3D0x800000010000=
0000 value=3D0x0000000100000000
> > > >> >
> > > >> > Is there a convenient way to connect NVDA2012:00 with the actual
> > > >> > device?  I assume this is typically a PCIe device?  How would we
> > > >> > relate this with PCIe errors?
> > > >>
> > > >> The CPER report is from ARM RAS firmware and not neccessarily be
> > > >> related to a PCIe device.
> > > >
> > > > Right, I know CPER is more general than just PCI/PCIe.
> > > >
> > > > But in this case, I think NVDA2012 probably *is* a PCIe device.  Ho=
w
> > > > would we figure out which one?  If we have to manually do an acpidu=
mp,
> > > > figure out which NVDA2012 is :00, and look for an _ADR or something=
,
> > > > that doesn't really seem convenient for multi-NVDA2012 situations.
> > >
> > > It's actually just an ACPI device:
> > > Device (CPER)
> > > {
> > >   Name (_HID, "NVDA2012")  // _HID: Hardware ID
> > >   Name (_UID, 0x00)  // _UID: Unique ID
> > >   Method (_DSM, 4, Serialized) // _DSM: Device-Specific Method
> > > }
> > >
> > > And that's it.
> >
> > Weird.  There's nothing for a driver to operate the device with except
> > _DSM?  The device doesn't need any MMIO resources?  I would expect some
> > resources described by a _CRS method or some native enumeration protoco=
l
> > like PCI BARs.
> >
> > The _UID 0x00 matches the "00" in "NVDA2012:00", but I think that's a
> > coincidence; I think the "00" in the device name came from the ida_allo=
c()
> > in acpi_device_set_name(), not from _UID.
> >
> > So I still don't know how you would identify the correct part in a syst=
em
> > with multiple NVDA2012 devices.  I do see the "socket" and "instance_ba=
se"
> > in the output.  Maybe that would help, but those seem to be
> > device-specific, and it seems like we should have a generic mechanism.
>
> It's not unique in ACPI terms.  There are a few cases even in the ACPI sp=
ec
> of IDs that exist just to say some feature is there.
>
> ACPI0017 is an example. Simply says, there be CXL here, go look for the
> tables.
>
> Here this device is used to indicate that a platform should be ready to h=
andle
> a particular type of error record.  If it happened to expose any other
> interfaces, then I agree it would need resources or a _DSM etc.
>
> Basically it's a workaround for the lack of discoverability in APEI /
> ACPI error reporting. Could use an _OSC bit for the same job but then
> we'd run out of those fast.  Device IDs are near free.

Well, in principle, an auxiliary device could be registered when a
given ACPI table was present.  It would then trigger a driver load and
the driver would probe against the table in question.
