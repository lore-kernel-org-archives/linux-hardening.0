Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010041.outbound.protection.outlook.com [52.101.201.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126F53C9424;
	Tue, 24 Mar 2026 09:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774344799; cv=fail; b=kpz8R+1VMrEymHWTZZhE3rCi23RdmvVuewV828/bUs4fGhC+tGuDICygLN0jwaY07DXU1flwiGf4+Y6PkfY370Jvor1KfQbE04cqsVvlTtFPBa0sEDoUuT2t9VAJo6jYhKFfMzLMFDls9PwZw9y42TtMFsYBBcFhsPZjQCdPrqk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774344799; c=relaxed/simple;
	bh=5p24lGmFZNQEPLj/uJqzWcR2EScfO/crGkU4iBJnx1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mEQFws2o0I1Ql86gN5P3eSTbC6PmWzRHf/9I1vmVGVGiT1QjjWIFTVsBOs+QhDu/MpMQLLhGau53bcxGs86DupbfYld2NCIIfdGsv1DqoF9zQa40vpNhlW3VJ+Z5guoDsTcuuzrAUkoPlZQQdxcgCx2v6J9xj5rPilO8hK1lSlQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rXEeuRwX; arc=fail smtp.client-ip=52.101.201.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rXEeuRwX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AyYwOeXOV/ps0WUeIMDNjg6ajBihArUswcC9fNCCcWy4M5F+ZihHbGvyZHz/SvNdP/7aky0G4NR02DGRrt2SRnrnD4irxVeraVXeKPa7DMSgp0JdkxNERpIUUZrDurjYfUv21sQr+p89fU3v8RkfRmxVpENxNvgtjkxTVAXcZOvJ7luDWHlpQRmufvhf+w4AMlnOepcLnlmUbvwxGN7NtrO0juZn/+oHJidMk7/G/ZrNi5YuZAb2+ngpIQ8HawEsLsgPriBdtxAHqi9s1nqPS2TvnrvlHCFQCAZ97mGEMdQmaE3q4e1KLa75AEQlu5WjwHuAdjxkz4crx+/Btp3mog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Jn1rxIMqtrVY3VP4T+i8sj/pQJQHg8ZWnKn799NX1k=;
 b=baxG1NZCA6fn2krMbM1gDezQ31ydsWl+v5hKd7kU8NUedko+w/5aFdHeq/ovIdItdAjPyzAhe8HHEM1GTRxEWYxKUUUMSAfeOkMfvL46wk48vfaugDod/e70Tv5Z10YZdpBQdofqma0zndzjU6OyYEXFaCcwR70HG87BlC9S5Rl+GW7nCb1vMvZZfoFY+LMjSZYkI0RdyRnrSM0JTdVtKWsjeneQXWEt97L4OppYac023jYmW9a8RTpKMm9Wp3U848rmb/B/uxko7643k4rP3V5p1Y0UiF7U2JfGcVZQf/s1vB8x228PczKnjESVjGgxEHXyiRUiN0AUFSoh9anHFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Jn1rxIMqtrVY3VP4T+i8sj/pQJQHg8ZWnKn799NX1k=;
 b=rXEeuRwXNCf/c9/f31fNs8xkgtpj32t3AFbRMOP2vgHiURoFtjoNQ/CoE7BNYe1fsV5QztXfSvxZoPYMCWOuCWAWCH2+3z/UUZ8oCURSWy8CiVnkReSzhyv/h7ti2nN85zUBe7DjQnvg2PvhfBLAPhn3uENFU9Oectpz28VlXOGmuO8aVK7jq8G8IHzrhwSXoWjYnw+WXRQ9S1tQecsWGjg5ZE32d5EUAKggeiutxJz9B8WHqpxKA5Vm2NzNx8g9pprcn2t7f/O8AmlSWytu7WY7yJ4nnoscdZGqp9MiImwDEazwKBPIJpjsraOFiUKp5YMEqoS7bcBuCSYX/hyJTQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB7914.namprd12.prod.outlook.com (2603:10b6:510:27d::13)
 by SN7PR12MB6789.namprd12.prod.outlook.com (2603:10b6:806:26b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 09:33:13 +0000
Received: from PH7PR12MB7914.namprd12.prod.outlook.com
 ([fe80::d390:582:5536:40ad]) by PH7PR12MB7914.namprd12.prod.outlook.com
 ([fe80::d390:582:5536:40ad%5]) with mapi id 15.20.9723.013; Tue, 24 Mar 2026
 09:33:13 +0000
Date: Tue, 24 Mar 2026 17:33:06 +0800
From: Kai-Heng Feng <kaihengf@nvidia.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: rafael@kernel.org, Jonathan Cameron <jonathan.cameron@huawei.com>, 
	Shiju Jose <shiju.jose@huawei.com>, Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>, 
	Hanjun Guo <guohanjun@huawei.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Shuai Xue <xueshuai@linux.alibaba.com>, Len Brown <lenb@kernel.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Will Deacon <will@kernel.org>, 
	Huang Yiwei <quic_hyiwei@quicinc.com>, Dave Jiang <dave.jiang@intel.com>, 
	Nathan Chancellor <nathan@kernel.org>, "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>, 
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 3/3] acpi/apei: Add NVIDIA GHES vendor CPER record
 handler
Message-ID: <acJYJlm2JZn_W7yO@M5403NF6WD>
References: <20260319111315.87624-1-kaihengf@nvidia.com>
 <20260319111315.87624-3-kaihengf@nvidia.com>
 <20260320145254.GB699200@bhelgaas>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260320145254.GB699200@bhelgaas>
X-ClientProxiedBy: TP0P295CA0009.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:2::19) To PH7PR12MB7914.namprd12.prod.outlook.com
 (2603:10b6:510:27d::13)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7914:EE_|SN7PR12MB6789:EE_
X-MS-Office365-Filtering-Correlation-Id: 43af3ce0-a9d2-4bef-5ddb-08de89885edc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	txBaLoxKUvduNZ0ABrP9/7O0p3C0eoMoNn2+MYmRv0cxWcZX/nt8aylVlSpdS40RDURGtj4a6K1Lrl3VCMsBEdn0tEWONn1hliekb82Ohvci08hQbufaxpploS+f0MwWKM7GzpW/tdLvLL9XJuzsIF4rrLTtWGU3ROmf/5pQI9t/sekMWiNHaUAUU+ngZpejlGPBrvqSpc+bHsjzmdu79PikrTGhGsf3nzaoQD/UBSauM9pZUin9QUEOtDxd9/HCvojc3CNHU+SXQyvXBe50aHC2WT9LgTLYYDoN5OTf3GZY+QY84DZ9POFwCFx6b9VIOcIB72SPsqL21RX2chntlio85UqKkZMB8ZFp1b9it2szBc/GfFCgX22RgPbSauQBRRt6mT5ybaQV1igVFjyshGlaMzL8jyM84jFGg2gbaCNe+lOah6xVjvHKBc1yp26pZb+YB4RHk6QDWdtEVmRl6K1p0U+IMDTDLIROqiMWWtrAtponcSuabTWlw6kUaVqFde91CP5jB6F+EsuSUwrAmTGjIglsZvJKjtrwhWZ/N2oqkeKZcY+00BTKESF4ctLaptcbvAXib4TELu9liLugN/R0chD3P2fA+g61tQq0ylJ86eYn5Wm11WI5fNQhx/66lh3/mazJlsP2DXfZFGZ8evFXDkZUXLseQARWddCSX3PEUF7lvc6W4NYh/ptQI9Z5qcPuK9ty4u4bbi+IQWjewTiGXRpqMBDKzpzN2ncGfHU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB7914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NVujh+Gdo8owZea7dD932PpFKu91kBZIGvl0THdORSScfKiX06qV/khOWEB6?=
 =?us-ascii?Q?Mfl0OkWr98rNajy0OVttXsFnUErR8rHoDxCt6Rptlt6nO1ZgoCvLm7MnIpIT?=
 =?us-ascii?Q?fGhVwiZv8FI+Kxf+BN+7NFEYFcBXKdIjJSlOTrwrLKz7J1T2CBA4hgqyDDec?=
 =?us-ascii?Q?+pwbAn+IcdL488plkV9f2dQBfa1nlmidr2s7dcoo3e+7BQK4RqitYi219TiQ?=
 =?us-ascii?Q?4ABGv6e3YQYB4rLOpAgjYCEtye1WxVptzKvQHmpT8gsYETSqTisP/8YO5cT8?=
 =?us-ascii?Q?TeppZIylpa4zrDIgm/z9W8AqDnW0bHdi/0boc+qynY9pAXxOc9DbdjctnSFp?=
 =?us-ascii?Q?17ZXn827yRVGrDEY9J79kQGUAiFAvKsM3ca7sXBL4PDZ44ljqqcDvX5jcROi?=
 =?us-ascii?Q?4v5+uUcm1TO/fy6OcbtsB1cKLVoIlJnQTwsSVT5HCmMq+WJXx0RU9PsykEO6?=
 =?us-ascii?Q?GmyW28VfPdOByYluI1B9T17XWQbqpvFqsyFmQ4q2QRS0voLp8x6XBb4NzuFW?=
 =?us-ascii?Q?3oIrX5Uy3y0Q62eHHcd1uahImol3B4BZFig6VMIuV6ZHaVKk1O8EJh+J2hFB?=
 =?us-ascii?Q?etOuqNXcKiVZoP+NQU4ZpIel8+D6CXkwnlAvzK8N/FJKPR/MDq0fsoGS7zGe?=
 =?us-ascii?Q?sZ6amRjHadQ4uU8SUepBDpjjfFBzIqLkZs7DJnDcuDYrVTs2swQlAYoUo8Da?=
 =?us-ascii?Q?5Or4cS5y+ujqtrcvs02qWpBAqpUTH/7C3hHzTwBrDfS/2og21SsSLNoXfyM2?=
 =?us-ascii?Q?go4nw/iEnuqPWFfWeoKPGX2XNblPw3/HQviCY6UAuwZWzrUOVUoW2H162PQb?=
 =?us-ascii?Q?q/QtzmbJHj+Vniyf2G4uEt3VUhci5L5jpr2NRj2qG5jAN3fBYu78MUS/2uq/?=
 =?us-ascii?Q?Pzb/lmI3ksOC4cjb/36bAYx5x7ZSz63pbEhFuGoDHY+inC/FEb/sfthyaGi2?=
 =?us-ascii?Q?niK6LUFF7ZN1OelKgY/RC+Pq1a32WaNbMq5EiDqreO/rR0l781IlN+sf6485?=
 =?us-ascii?Q?YzRUdFpTLrGB1pf8ceCKLJPvFBmTPKkJqAm/Xh2gvXsUZ2qHB4wghuYz4dHP?=
 =?us-ascii?Q?uMKo1npbpszKuD8T3121KNdAZTXx8VUz3XnHwH0UB2mvNrK62AyZwwJk/yRB?=
 =?us-ascii?Q?aeAiH/TKn4qoLQEe2XIFHd7fuxYj++bHr1Q6NQxd627+R8zVlWYfpCQNTAFL?=
 =?us-ascii?Q?ZEuRjanbnDWPF3qrRDkaMImv0j+/5dtApEFxk0aj2PptLGriXUobB9wYRSaV?=
 =?us-ascii?Q?ZyY9fX7dM4gYimA/zt/TH2d450+uQQ9vmwyaoENHVu2ChkqN5hZ2pVp5NhnX?=
 =?us-ascii?Q?O8ZWNTOUBZHVFfJ/f0c9c4defgLIOIsUs2xJw2F1Duz7Q7wGDKn7gH8ulLee?=
 =?us-ascii?Q?/j9H1se/qIjVcBRZH/AZgA7V88vOm2VmtWQm6kkHEOoKB8uvQfFY340yLQDW?=
 =?us-ascii?Q?u0ofVC5oYrjJOGeLfeuSRrz8kVeeK10bE28P6UqxDX/+3R29p0gw36J97iwU?=
 =?us-ascii?Q?a9ryyaBuO0mHJ/OErt27REabvVPbYrpllncje7OS8YLUEcyepoQSzUZkuvcv?=
 =?us-ascii?Q?zXDYvkM7nvEWLG/kCL5JkV57TzukFeeP5pRgQd3bxvK248+FeiBKtEuZFoN7?=
 =?us-ascii?Q?6jFaUIEHGBR3oMvwD6wyAYasKgd9aMAw8MWU+XomdkQSkFZZ+X7FfQaFgbRz?=
 =?us-ascii?Q?ABKj0pV0U2R3fkbjvfjSbRc3BVBbRquWkbJAV/T8bv+6XVwWVAcqbdExLpKj?=
 =?us-ascii?Q?h9L1yupdpQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43af3ce0-a9d2-4bef-5ddb-08de89885edc
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 09:33:13.6361
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wADm11okIeUUKk/je5lMOYeXokpF++P1nvW/44R5y//wSaYtLhPXT7oMkVYY2cFEhcfkawpfn0TpTLA44KTXjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6789

On 2026-03-20 09:52, Bjorn Helgaas wrote:
> External email: Use caution opening links or attachments
>
>
> On Thu, Mar 19, 2026 at 07:13:09PM +0800, Kai-Heng Feng wrote:
> > Add support for decoding NVIDIA-specific CPER sections delivered via
> > the APEI GHES vendor record notifier chain. NVIDIA hardware generates
> > vendor-specific CPER sections containing error signatures and diagnostic
> > register dumps. This implementation registers a notifier_block with the
> > GHES vendor record notifier and decodes these sections, printing error
> > details via dev_info().
> >
> > The driver binds to ACPI device NVDA2012, present on NVIDIA server
> > platforms. The NVIDIA CPER section contains a fixed header with error
> > metadata (signature, error type, severity, socket) followed by
> > variable-length register address-value pairs for hardware diagnostics.
> >
> > This work is based on libcper [0].
> >
> > Example output:
> > nvidia-ghes NVDA2012:00: NVIDIA CPER section, error_data_length: 544
> > nvidia-ghes NVDA2012:00: signature: CMET-INFO
> > nvidia-ghes NVDA2012:00: error_type: 0
> > nvidia-ghes NVDA2012:00: error_instance: 0
> > nvidia-ghes NVDA2012:00: severity: 3
> > nvidia-ghes NVDA2012:00: socket: 0
> > nvidia-ghes NVDA2012:00: number_regs: 32
> > nvidia-ghes NVDA2012:00: instance_base: 0x0000000000000000
> > nvidia-ghes NVDA2012:00: register[0]: address=0x8000000100000000 value=0x0000000100000000
>
> Is there a convenient way to connect NVDA2012:00 with the actual device?  I
> assume this is typically a PCIe device?  How would we relate this with PCIe
> errors?

The CPER report is from ARM RAS firmware and not neccessarily be related
to a PCIe device.

>
> Consider a cover letter.  Some of these comments apply to the series.

Will do in next version.

>
> Wrap commit logs to fit in 75 columns.  When indented by "git log", all of
> these overflow 80 columns by just a few characters.
>
> Possibly reorder so the acpi/apei patches are together.  I don't think the
> NVIDIA record handler depends on the PCI patch.
>
> Typical subject line style in drivers/acpi/apei appears to be:
>
>   ACPI: APEI: GHES: Add ...
>
> > +config ACPI_APEI_NVIDIA_GHES
> > +     tristate "NVIDIA GHES vendor record handler"
> > +     depends on ACPI_APEI_GHES
>
> Maybe s/ACPI_APEI_NVIDIA_GHES/ACPI_APEI_GHES_NVIDIA/ since there will
> likely be more, and they'll sort nicely if the vendor is at the end.

OK, will do.

>
> > +     help
> > +       Support for decoding NVIDIA-specific CPER sections delivered via
> > +       the APEI GHES vendor record notifier chain. Registers a handler
> > +       for the NVIDIA section GUID and logs error signatures, severity,
> > +       socket, and diagnostic register address-value pairs.
> > +
> > +       Enable on NVIDIA server platforms (e.g. DGX, HGX) that expose
> > +       ACPI device NVDA2012 in their firmware tables.
>
> Wrap to fit in 80 columns like the rest of this file.
>
> > +++ b/drivers/acpi/apei/nvidia-ghes.c
>
> Maybe rename to "ghes-nvidia.c" so future decoders for other vendors are
> grouped?

Will do.
