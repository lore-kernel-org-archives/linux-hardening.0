Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012044.outbound.protection.outlook.com [40.107.200.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92A23DCD87;
	Tue, 24 Mar 2026 09:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774343466; cv=fail; b=oZ2Z/9dSqeUYpJddlx7T94ac7SXAfmrueXCkBKViY8RKp69H1VU3g1u/n12EcVVe38ou0cV8qMc3pz25Tc4BFgqXqBUNVq3NAQeMKc1a1/mSsfLQFKD0NzAPZ/4D4Maiqd0//47UPt+doNm1X3Tem0kor4AFY7MFmwFOw9Hb4q8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774343466; c=relaxed/simple;
	bh=39Toe0h9FeidvUkwyuyjVFCj60rBcBbs7X18/edkiYk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IGBJNKT3xryROtGFtf+X3Cp7H6/wfuv7zgUxovAAPCZQN/jNIH1nwYeApjSUBvOryfhBqf4LILIhh3DrNeTmvcHPWQF2uSINAJwAEKTCgVW45F+2R/dpAJ3kgDhILpBrwBgd/epp0aGo/yvuKljUkqjBxt4qf516dHG7m+nzkAQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YIp0gh8J; arc=fail smtp.client-ip=40.107.200.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YIp0gh8J"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kSLiQat/H2rYtI+dv1FrrQPjEC+7410DpvQol3H7SZr7kegJpD+/wMaWMz843RaAekQPThaG3K3Z+mAYThUzzVSKUSQQiEw1+dwOf3kUYNajE79VzzTauauWZN2pGtTpQFgmJxKn0t8Ckhmf7l+kneRcs3vU+hjfxNUB4G5bFjFCbIQ8GSzec+qbfvKTnKKLb5gmDgTajAsVkdKFLXWErJpb2mYXx8BBC1srJsslzqHNDVy3g2jTv8m0RtCBswk11VaddZ9gHnDVD9Vl49ihQKzKkHtS22oCU5yrHV3CDTh0Fg+G0zcL74iTwAwOPLVbcNztTrjXrcIs6v5io4k4cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6RQk5D1CVFeGT5l4NFIvZtMNys8kwJ/KsBPQpLHzpKY=;
 b=j2QFkUDB8oJR2YZG28balKATN0A27QsQa5tIIqkD+gdkLBdOSRP8DlX7I0snv1XT2Hu3ubXmhJzOmHVsXRqHfI9WXovV2rwpJQaomnZ4Tkw8p/XdjPQ1GZHXkNeRb+7riiPE8aaJ+WXh20a6HoinVkrV4fwYDO/ut0UzbjxklOV1txORNjQrfBq14o/6wnR9bCXK2NmTSMyLS7GJbR9hWXI/aDjj24T/uKJoVuo+vP4M4GeF6+4RZ1i34mso1Af3HpXtvJzWcjUS0HILsspR2nboXVjQHlZNUmWfXR4vhdYjBlBMmSG9g9hvPxM5MIJoEJUzGUwN+7fTvvW8Byb6yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6RQk5D1CVFeGT5l4NFIvZtMNys8kwJ/KsBPQpLHzpKY=;
 b=YIp0gh8Jro5F//zIgUQswyusDYQXhjm8UsvdsS0N/filmeyNzOCc8mrukSJldDdCoaBtgxgI1zHhPjPQB7gg8Ht4MPnl2J2BSUdWh7B1nxg6C1gwoh+PvfmRfwVqPQ7gx17B3i1f4wMLqPyRbK8uY3safp4xf9KVzMjEOHqMFmMEYkapcRkX8gKrdL/g3VrNQT2cBTVS7+aEJJzHORRFDkMX/IOsh8PeQrHUKfRA06YBvafvf6yYWe2Oxw4IXvjhRiaLHOdh4da++BYLZ3mH5lT3XvqjhBCLXjmaH4Vj/kvkgvGHapsFqAneJCXC8E5vjWxtw5qWYuqqva5GEkIXow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB7914.namprd12.prod.outlook.com (2603:10b6:510:27d::13)
 by PH0PR12MB7093.namprd12.prod.outlook.com (2603:10b6:510:21d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 09:10:55 +0000
Received: from PH7PR12MB7914.namprd12.prod.outlook.com
 ([fe80::d390:582:5536:40ad]) by PH7PR12MB7914.namprd12.prod.outlook.com
 ([fe80::d390:582:5536:40ad%5]) with mapi id 15.20.9723.013; Tue, 24 Mar 2026
 09:10:55 +0000
Date: Tue, 24 Mar 2026 17:10:45 +0800
From: Kai-Heng Feng <kaihengf@nvidia.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: rafael@kernel.org, Shiju Jose <shiju.jose@huawei.com>, 
	Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>, 
	Hanjun Guo <guohanjun@huawei.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Shuai Xue <xueshuai@linux.alibaba.com>, Len Brown <lenb@kernel.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Will Deacon <will@kernel.org>, 
	Huang Yiwei <quic_hyiwei@quicinc.com>, Dave Jiang <dave.jiang@intel.com>, 
	Nathan Chancellor <nathan@kernel.org>, "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>, 
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 3/3] acpi/apei: Add NVIDIA GHES vendor CPER record
 handler
Message-ID: <acJQOXJ2mVSj3un4@M5403NF6WD>
References: <20260319111315.87624-1-kaihengf@nvidia.com>
 <20260319111315.87624-3-kaihengf@nvidia.com>
 <20260320101335.00004026@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Description: 
Content-Disposition: inline
In-Reply-To: <20260320101335.00004026@huawei.com>
X-ClientProxiedBy: SI1PR02CA0055.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::16) To PH7PR12MB7914.namprd12.prod.outlook.com
 (2603:10b6:510:27d::13)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7914:EE_|PH0PR12MB7093:EE_
X-MS-Office365-Filtering-Correlation-Id: cf48c983-1531-4c9c-e716-08de89854136
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	VSw65Ym21rinb5LcxHElPeJr9b6AKAze4+WBu8iQd4UZHFVCvK3oTx1fsvc1Ux/kIdhe3yyQTbyM/M5SJUBSYkBW/JVzGdEbQnQ8kuFmfDCAvMYFsA6IogHttX7KaVk0ofvk5uKudiNsGyZ4qLJcj30uYAGHACUcbrGCPXwXzxmHTTGed37o+I8L3yn/tpVkZeHyk4sJxRySjQamwEDw6mVjXPPOzNCemJGpAxXz/q53rl3KKeQDEPLrggrzp4OiEIvkJ7Z0tcWY/UNQfjvT8LXlqHtNCjmiWfu8ujDDSc2/eh79d3zwmaCh9R9iY7LYbMEkOIk0crTEmA2rQ4BYF7mjyHXZwcLNuE58GYqmFZNlkKB+XkCEqHOktp6LNF9q2OrvbC3hUG345jWVO/tRXDNJNDXdAvve5S9FPT6m7ci2vfNTCwAeUpCVtOlik+BFp4IJpT3ikwn0n9JSUZw/2WIaSIC/6qnfUnrJbK329Etc1KL/EVs6QLlt3jN7NhMZyNFWUZ7hwNSjJzKHFquNL8LH5HP8QlzzqjVEYLuAcuGw6m2J8i92yh/EJEBMnknPYTo92eEP/VNDT79HDJt4FpNWkMLbQypo9Uke+33N43Y/wO4mXn+IIwarkwJZ2DvbtmHNXaXYVCSCO8DhMnkaPLV9SiK86lL3DSNHI/KbX0AsDw60O+jZosFIDJN9pQ+9/j2gUx+FRCJWHkXcnP5oXmCEi9gc1681QuOLZCWoXN0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB7914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0GzdRjh5IzpOiAgC3wK2j3csf929569P5VeDYFvpee+1I6MGzY6p4eAWyaxb?=
 =?us-ascii?Q?nHMOYomx14JC6VBCpdgOQUsU/XDS+ulq8Qnv5WVhc8eO+Cr/Iku11p3VbDGE?=
 =?us-ascii?Q?RSSKNs7dql3OGxa3jtut+yhp0ETr1+6fMmdqOstX0GAFmBEI1q9ulAixBEPg?=
 =?us-ascii?Q?9/0i245La9PPZNPQ07/9UKTwZtXvdOSzqh7S9ePlfqTk1TO+wNha4BjECIk2?=
 =?us-ascii?Q?s11MW9pypAckTseaRn+Wy5/ooUf27vvWbNM73cbbPwPaJoq0YZ3d8jHeO778?=
 =?us-ascii?Q?2aAhaep6XTJrqFlU31tqf0UUa9me9Z7o7c6EnVRaOCIl6GGChnUQdLNFOjgt?=
 =?us-ascii?Q?d+X7sFE7XhVSc8AdPiTL2gOIEev5Z0uZfEmBVppVqpP1ZsB7LIMqkMihWwg3?=
 =?us-ascii?Q?8FB/rjuwLQaca4+OhE8RArcz9+YqJBvVWMY4Uxasi+Ru/geoGb/69N6JFuAL?=
 =?us-ascii?Q?BpW8g37tQCEXZjJha8uoB8GXlWWNa6XFpyV6jg3xtKYRGiZO07wF4mC0nxu1?=
 =?us-ascii?Q?rSuE5aOzxXOYj/EH9DKz55Pz6f7UfcfERUICeAtOsfNmbPlbWFEtjgmZsyMp?=
 =?us-ascii?Q?yi1LNn0F6mo2jACpvNQz2XIkHwo9YPsrxQlzTopcF+bxjwSnJw/jzremByxu?=
 =?us-ascii?Q?VcxHmEdpjoYtwYEMBMceKbS9Wjlx1ie9+Ayvw5t9VM6EvbuRVZegW8Ok5KY2?=
 =?us-ascii?Q?xTxn8kFOGsVPc3vu7pne2v4/hNfhEp3TmOTeovhL5hWVYI0Ht6K9xx1Auo2a?=
 =?us-ascii?Q?qhrppoDaDoW+AeX+05j+4ptdklFwWMZDDoETTjHdti4dA8iLexICtGey1VlP?=
 =?us-ascii?Q?UEKkzk6uVnrp9EAubYqtb+hjGwHRoaBFZECPPEYa8qQIpNJGqFh5T7A6hJNy?=
 =?us-ascii?Q?cx96s102aX4LKW9utIyCaUkyptIP7oeuPHAONixuASrtZmKac+9H+V3u5ik3?=
 =?us-ascii?Q?Ays3X5dybEOVgXyqvtYABIDSejH8HdAjl2rej7biDa3TCoOa+ib6zcaMMMMv?=
 =?us-ascii?Q?dyLsG5iz9nmbh2mEV4/fpkIijv0yFehboH2HV29MP0A4GnEccB0szii3Li/b?=
 =?us-ascii?Q?tHP4vAQQ4Itol4a6ZPbus+yawrU331c6ivdsc9mMW2y3IvPy+kKai/3oVbez?=
 =?us-ascii?Q?PBhr2Wiy63ntvY064u+av/UBTHXkcfTFLpFRDyNu8RPNheJnIdaYEmbdAKyT?=
 =?us-ascii?Q?f3YdF2pbm62i6ZGBvtEuuPJKAI/3DBvE+UFPQF5Fncn0TkXFozfOrWasgNcO?=
 =?us-ascii?Q?jbtpXtR+qrQiTEdaSIrgwNbhIhGWBXvgLptEMWKT1DMNYLSTyvFYgsoTp1eu?=
 =?us-ascii?Q?dTB5WPH8PVI3EOyCgvhoa2lyeMHzcNbLHRUMzIPo/fcpVFo5jDnceoMYmj3u?=
 =?us-ascii?Q?113uyleDyd8Faw1pyJa0OhErt6WV+iU2DJRbgxFwTH0Q5OZTFlR13gkrXqqt?=
 =?us-ascii?Q?NGnR8ydVNvnGUMd6v+iQA+bDfQrN4AhswLEovFlc0gGwBJpwuF9lyWomflBD?=
 =?us-ascii?Q?Q/yORgeK2WU6bi52LQMBZlWCT4dlRYu0L28tpJPP6D2s7zFByNHRzmK9Toi0?=
 =?us-ascii?Q?S8ackur3xSaW1gbyIY0hCAyRSjh4DpA2KRtots7yvZr0kdm1H8rxn7UuQWMD?=
 =?us-ascii?Q?oGnr6kOX2zw5l90JEq9/4ep7Ig+zp1j+20vtLGrDzQHCmcf1drSieVBeDx9h?=
 =?us-ascii?Q?cBpzZnwrvoRSMGnQIA9RODlvilmnOpgLBCBhNPpTUqMC2PUcdAtkM2Cb/ydh?=
 =?us-ascii?Q?V95QhDCqrw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf48c983-1531-4c9c-e716-08de89854136
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 09:10:55.4413
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T6x5E47rGMj6PwsVrFnlz/TwPiA82fJ1vyx+wYJg2AkW9LA4dgawbqPWdXHS0YskBNew7kBOoTQOSa4oJ5qJbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7093

On 2026-03-20 10:13, Jonathan Cameron wrote:
> External email: Use caution opening links or attachments
>
>
> On Thu, 19 Mar 2026 19:13:09 +0800
> Kai-Heng Feng <kaihengf@nvidia.com> wrote:
>
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
> >
> > [0] https://github.com/openbmc/libcper/commit/683e055061ce
> > Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
> > Cc: Shiju Jose <shiju.jose@huawei.com>
> > Signed-off-by: Kai-Heng Feng <kaihengf@nvidia.com>
> Only significant thing is around use of dev_err_probe().
>
> I'm surprised that didn't give you error messages in the log even on success.
>
> With that fixed (other stuff is all up to you).
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
>
>
> >  apei-y := apei-base.o hest.o erst.o bert.o
> > diff --git a/drivers/acpi/apei/nvidia-ghes.c b/drivers/acpi/apei/nvidia-ghes.c
> > new file mode 100644
> > index 000000000000..aa2e3a387b49
> > --- /dev/null
> > +++ b/drivers/acpi/apei/nvidia-ghes.c
>
> > +static void nvidia_ghes_print_error(struct device *dev,
> > +                                 const struct cper_sec_nvidia *nvidia_err,
> > +                                 size_t error_data_length, bool fatal)
> > +{
> > +     const char *level = fatal ? KERN_ERR : KERN_INFO;
> > +     size_t min_size;
> > +     int i;
> ...
>
>
> > +      * Validate that all registers fit within error_data_length.
> > +      * Each register pair is two little-endian u64s.
> > +      */
> > +     min_size = struct_size(nvidia_err, regs, nvidia_err->number_regs);
> > +     if (error_data_length < min_size) {
> > +             dev_err(dev, "Invalid number_regs %u (section size %zu, need %zu)\n",
> > +                     nvidia_err->number_regs, error_data_length, min_size);
> > +             return;
> > +     }
> > +
> > +     for (i = 0; i < nvidia_err->number_regs; i++)
>
> Trivial but I'd take advantage of it now being acceptable (in general) to do
>         for (int i = 0; i < ....)

Didn't know it's acceptable now. Will change.

>
> > +             dev_printk(level, dev, "register[%d]: address=0x%016llx value=0x%016llx\n",
> > +                        i, le64_to_cpu(nvidia_err->regs[i].addr),
> > +                        le64_to_cpu(nvidia_err->regs[i].val));
> > +}
>
> > +static int nvidia_ghes_probe(struct platform_device *pdev)
> > +{
> > +     struct nvidia_ghes_private *priv;
> > +
> > +     priv = devm_kmalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> > +     if (!priv)
> > +             return -ENOMEM;
> > +
> > +     *priv = (struct nvidia_ghes_private) {
> > +             .nb.notifier_call = nvidia_ghes_notify,
> > +             .dev = &pdev->dev,
> > +     };
> > +
> > +     return dev_err_probe(&pdev->dev,
> > +                          devm_ghes_register_vendor_record_notifier(&pdev->dev, &priv->nb),
> That's too not great for readability and dev_err_probe() should only be called on errors
> I'm fairly sure it doesn't have special handling for 0 so will call dev_err() or dev_warn()
> and print some stuff before saying 'no error'.
>
>         int ret;
>         ...
>
>         ret = devm_ghes_register_vendor_record_notifier(&pdev->dev, &priv->nb);
>         if (ret)
>                 return dev_err_probe(&pdev->dev,
>                                       "Failed to register NVIDIA GHES vendor record notifier\n");
>
>         return 0;

OK, will change.

>
>
>
> > +                          "Failed to register NVIDIA GHES vendor record notifier\n");
> > +}
> > +
> > +static const struct acpi_device_id nvidia_ghes_acpi_match[] = {
> > +     { "NVDA2012" },
>
> London Olympics :)

Michael Phelps did great :)

>
> > +     { }
> > +};
> > +MODULE_DEVICE_TABLE(acpi, nvidia_ghes_acpi_match);
> > +
> > +static struct platform_driver nvidia_ghes_driver = {
> > +     .driver = {
> > +             .name           = "nvidia-ghes",
> > +             .acpi_match_table = nvidia_ghes_acpi_match,
> > +     },
> > +     .probe  = nvidia_ghes_probe,
>
> I'd just not attempt to align the =
> static struct platform_driver nvidia_ghes_driver = {
>         .driver = {
>                 .name = "nvidia-ghes",
>                 .acpi_match_table = nvidia_ghes_acpi_match,
>         },
>         .probe = nvidia_ghes_probe,
>
> There aren't enough of them to make it much of a readability improvement
> and doing this often results in unnecessary churn as a driver evolves.
> Also it's already broken!

OK, will change too.

>
> > +};
> > +module_platform_driver(nvidia_ghes_driver);
> > +
> > +MODULE_AUTHOR("Kai-Heng Feng <kaihengf@nvidia.com>");
> > +MODULE_DESCRIPTION("NVIDIA GHES vendor CPER record handler");
> > +MODULE_LICENSE("GPL");
>
