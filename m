Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398E41F92A;
	Fri, 14 Feb 2025 15:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739545283; cv=fail; b=hPI3//qNV56/jfmprqz2ZUaDA2dZxuX/oxQN768aUKL3nHpUjtD+Twz+McatHA9SK15bLdTMrDGcQfr1dMKgiV5IElNeuAFnH95qwjdz7bV8lSePYYVDAIy0NhSVz67OTb5OlFc785O2R5QfntGmv9tREZ+6srjku4xyJava7CY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739545283; c=relaxed/simple;
	bh=Jxcde2uru/QUxPLeP7t+0RVDtWX9SOV0n+jVuCtmRSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JtEAF6N5VdHl58SdhkklPhYY3LdGJId96IHrHPgdqPd8TWvwo5VZ4qGIskf/0d6GZlAerCMRCe1z7iEzf3Q8xt0QYs9r/aZUR78hKYz+HTxwmGuNFM6LY7YtPWw2rsLdF9iU3lR1OrCTSrZat4FOin0ZFLe13E+JV1NDSO9iCbU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=emuFhUnN; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=PX64W42V; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="emuFhUnN";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="PX64W42V"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51ECtR1A011440;
	Fri, 14 Feb 2025 15:00:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=Jxcde2uru/QUxPLeP7
	t+0RVDtWX9SOV0n+jVuCtmRSA=; b=emuFhUnNNZ5CSwPTAfLHqdlseGUInQ2Hw3
	ZCYumpg//mE5NIE7z2wm2R7D900rcJsqIYlMS0KYNet8Q2BqG913iaDmlRAje4sd
	BVp0T2i3iqLHSR58f1obL+b5JWLrBkFFdfFstzqVgA/ta35RKsojXo1zTDUC8eIA
	B5Xzsl6BiK0LqP1toGS4hptRFkxKx+nQ0PI8uZhFs18USsaSDImiKkebMXJFWn0T
	MW7Ac8mxJrHqT49KL6ADWuwyMKK2becneNjGR1tck28/0g6vz5XRW9etevPxIByn
	Ebri1lp0bmSu8Rh7xCiTyrNWtsQi6R2nCaFrfFeFj8NADV2xr5Kg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44p0sqc0m6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Feb 2025 15:00:04 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51EDX6cv012452;
	Fri, 14 Feb 2025 15:00:03 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2049.outbound.protection.outlook.com [104.47.51.49])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44nwqd8kfg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Feb 2025 15:00:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r8g3ZLqQTf5ajk/xnqZqtX0j4dLxOsfp0HNDlodnMQwmicgRNryNIDcw6BELtVf5ZJKx16WVVYua2PD/phhLrJWOPmEc0PZzlwC3N6uoU6rISvu2G8inxe6D22TOG8/jB1W65ONTmBTnkGn6ZiICMcGQV9RIxzzBY+iK6gDxzcu3xz5uNXkpheXzmyjmHgclzq1J1xfI8fQYyMrsABB8H1EmK5DuZd2EenF8xysKsmmPqnhysxlS6wWyfK7/bL6dH8n0zukxiORbaSi6II43njLceaW1LDeAyhfLoIbVDujcQWxlZ8uA/lm5EwOF35TnkbPQNA2pwD1Ubpzgf7pqnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jxcde2uru/QUxPLeP7t+0RVDtWX9SOV0n+jVuCtmRSA=;
 b=unJhMYgmRvkECoLXLNvexCWnpKY6VHu8ZuHs0+6qyvsoE++0gv/6gS7QQ/7PwW4ebBbEIg5EC3WjgNCHWX1GYk5hGcgSXMNSl17lzGkwOBCCKIYRRPd6mYK4uyKNPlLDGmiAYBhsKD/moLoc53222tZFgalpVCzrTsIisFGerrE9u6TvN6m0kQGxyTjwLzPZXJQ7BPvjkZy/DxYORy+3wgu8e3qs20mi1lPSUt+P/XikNFAhYyUUznmmikngz/rtzznmDE+Or09QzIvtEsjpJz7D7WnIkPqa0Tx14E3xchMDumrfjf0YRJEKUq1W7GF+muaSn2dJoR3DR7Yi7jO6cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jxcde2uru/QUxPLeP7t+0RVDtWX9SOV0n+jVuCtmRSA=;
 b=PX64W42VyvZNUL94VV9U/h2NDFR7828vdwLlG0i6wI3OEaQrr53iEq0O564hB2eMyXWn9HOPc9FXGxFMJER6qdXjvVBzhFWDxzqmO75aoYmZ3cA16w5asyhA6Ic+nVAhvo1T95UBERivPtSXuL6xAD5uSp+X+HJMOuqD1+qNZUA=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by DM4PR10MB6909.namprd10.prod.outlook.com (2603:10b6:8:103::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Fri, 14 Feb
 2025 14:59:58 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%4]) with mapi id 15.20.8398.025; Fri, 14 Feb 2025
 14:59:58 +0000
Date: Fri, 14 Feb 2025 14:59:55 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Jeff Xu <jeffxu@chromium.org>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Kees Cook <kees@kernel.org>,
        akpm@linux-foundation.org, jannh@google.com,
        torvalds@linux-foundation.org, vbabka@suse.cz,
        adhemerval.zanella@linaro.org, oleg@redhat.com, avagin@gmail.com,
        benjamin@sipsolutions.net, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-mm@kvack.org,
        jorgelo@chromium.org, sroettger@google.com, hch@lst.de,
        ojeda@kernel.org, thomas.weissschuh@linutronix.de, adobriyan@gmail.com,
        johannes@sipsolutions.net, pedro.falcato@gmail.com, hca@linux.ibm.com,
        willy@infradead.org, anna-maria@linutronix.de, mark.rutland@arm.com,
        linus.walleij@linaro.org, Jason@zx2c4.com, deller@gmx.de,
        rdunlap@infradead.org, davem@davemloft.net, peterx@redhat.com,
        f.fainelli@gmail.com, gerg@kernel.org, dave.hansen@linux.intel.com,
        mingo@kernel.org, ardb@kernel.org, mhocko@suse.com,
        42.hyeyoo@gmail.com, peterz@infradead.org, ardb@google.com,
        enh@google.com, rientjes@google.com, groeck@chromium.org,
        mpe@ellerman.id.au, aleksandr.mikhalitsyn@canonical.com,
        mike.rapoport@gmail.com
Subject: Re: [RFC PATCH v5 1/7] mseal, system mappings: kernel config and
 header change
Message-ID: <8ded890d-f88a-4c59-acbb-8df3418c4a98@lucifer.local>
References: <20250212032155.1276806-2-jeffxu@google.com>
 <qrxmfa6jvaojedmo6fle2e6vd5k4hzihcuxdc6zk43dclf6nsd@dvuzolusdtz4>
 <CABi2SkUWGXtWAir5j1TO1c7FwOhbNmSwEzwTrxRgzfBydus=2A@mail.gmail.com>
 <66q7feybn3q2vuam72uwmai322jdx3jtv2m5xmh75l6w6etqiv@knpsyh3o627k>
 <202502131142.F5EE115C3A@keescook>
 <t5hsasch3aybjujmjzs3shpiorcgzp5pjc4fmz77u574voi3hr@qomzrd2llv2q>
 <CABi2SkX3o-PdeuzownVkFT-oo8tjtaaS9ebOALu+r6O1S6W3sg@mail.gmail.com>
 <tfoitovawb6zwr7nvwfo2mnbahgtnoo6umvecj5mgtie4b5vuf@sloraia3ppfy>
 <ex3y7knp5kmubeauwktvv4fdjqya7ndatzm7ht4gf773c72hc3@y4ow7k54fttj>
 <CABi2SkW_CqwNXFu9BUDfTX07aq5T8OAZern9hL=WumEWqK=ZFA@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABi2SkW_CqwNXFu9BUDfTX07aq5T8OAZern9hL=WumEWqK=ZFA@mail.gmail.com>
X-ClientProxiedBy: LO2P265CA0191.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a::35) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|DM4PR10MB6909:EE_
X-MS-Office365-Filtering-Correlation-Id: 209634b2-4141-4497-5a6c-08dd4d083ffc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KqXN9dfiXpRv3D2SD3xvVtdocs8HLMyWLHZKACI1kHaUWRuUa40jQpDCtb2q?=
 =?us-ascii?Q?iTJ8KWLBGpv5GoIpWYY6I9yuRbvlkZMTBUUw6rT9l2CxeIOAEazQvzxhVzCK?=
 =?us-ascii?Q?tpHnetnHWYM5RrnQCJl2o5rx5SuTrCvykjik9+p7vn+rPX69gKX0P2LS/Txl?=
 =?us-ascii?Q?0TrITRNxhxikjCzo2eGYk92ClF0OxybQWsQyf9Bw8AjRL/C0o5phYubTiB91?=
 =?us-ascii?Q?3OPimaIShq1myHqnmMD9X82TaJ7t1qwJhUN+fNgP/C61kvxmKuhbhT5slN9V?=
 =?us-ascii?Q?g2qHYRYQiAy/3BUzKV21bqxD2GRjdIGlyNI66Gw8/rSvX9fM4Nrlb1IuSvVy?=
 =?us-ascii?Q?prgeCkY5XsXMjBYjYVS7NbQadPJ4Zv0tB2zwDUgQK6NS06qTgLiTW923Z8qZ?=
 =?us-ascii?Q?6ikecUa/8b+ISBUxtAus4DMdXhY7iX5CaQ2Kb6Y86NyScsHL97JkEgeSDoJh?=
 =?us-ascii?Q?S4e0m3aDu/WFyVJrHAqCJ8EsvfYpEKPiZpE9VUT3BTIjEoGQIR5yr2B/pcQW?=
 =?us-ascii?Q?DEK9/W02SzQJ6LR2wDx/nFJVJ9Bw3zVBQgwEwH5IG1zWfTp/YKzItU8wZjmG?=
 =?us-ascii?Q?cqW0V+lc7YKoR/9mxdetErpfprue0W0ltAPJ5kA2kUWJnXbONZwgYvyRJYN6?=
 =?us-ascii?Q?MpdTPWyr54F7MRx6VIezbqcLfTLsTOGWXn6X6KVBvpz1Z0/QJWVN2jIt2F9N?=
 =?us-ascii?Q?LpZC3iAu0ZUTLM4mE9g5NXFQmubDISXZEVHI3BzhTcsPnt3mdVpRD4Sbl1Ig?=
 =?us-ascii?Q?0qDDKCOEWl1pa6+G3yeW32id8PJiEvcvV+MEEsYc9y1PEUUdY1mJSx2kjL2v?=
 =?us-ascii?Q?rgUcQYe5srRbJCdbqR7DWBX+85BoIGmy1eY75yF5Y19FagE+ziUyUMZgLuWQ?=
 =?us-ascii?Q?BD1qjMYPwxST4mdo9Q3lpgZgenCrT//hysq1jMERz9vuMZqRxySMsWqDz8Kd?=
 =?us-ascii?Q?MaOCzjQIlrfn9jFE+jxcX1mHc25+v5XAh/ic3OUrOUwGDJEv1vP/3lm2qB0M?=
 =?us-ascii?Q?GLVKOtXBYGGNFzOMDXlOpEriaB1c64u7VPTRDmNQF1m/Ia1E6OsSYE3UKPhM?=
 =?us-ascii?Q?Fvj/sZrenFYsMSSBdl30Im0+xMkUNzcHJBNwYnb+bTCv/Lcko+qqCVxAhUp5?=
 =?us-ascii?Q?AM9YXFacnLWqyZ8CQK+B6OhdcRWvKX+AqDy3YoSKe3SjUr/e2NtMQ44vjqin?=
 =?us-ascii?Q?b9a6OdS3ZIe7g0ekSAwtkugaQE70iBp3j1fS9UuXj9grHIn4bl/Kah8iw/Cn?=
 =?us-ascii?Q?H0QPlTXk/U7rKyc850zFyKVjYkT6NvxuvbZih7wngfhdXC0tL+VwIawtABxj?=
 =?us-ascii?Q?r6qYc9DUZUyhXM+hSb8zSykDXDQpVeGzjW7ivey2lMyv/fGS2x48IlFY1VIn?=
 =?us-ascii?Q?UmqlSK2s/z/+Wc3dR7ZDdgB7Fobn?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NHA7CEAXYc9FOXXvb+w2XksmeJO+1wZe9sPUU3z4Smdu7CAZkjNAf94WMbJ2?=
 =?us-ascii?Q?Rec/Bf9L3isJYMT5ntDD4PCfOICyeNzZFlGOu1I6+HRG5owdS89xWlAsyx5i?=
 =?us-ascii?Q?5Xoh8zEM7hA5g7YSW0JvXXrMEXSU7vrNKmsO2LWe/Zplz2UsbPqgLdfzNTNL?=
 =?us-ascii?Q?DiBgPnR1zaxpyaq4dp0RSHidoNPDo2yJwUMdSCTziCPXZcYCb3LUXj8DRYYp?=
 =?us-ascii?Q?05LQu94azBooRW+Ry5lozmjl6zHusHorx7k1XZ7qUuWvvBdWR0n5yJuC0Gb0?=
 =?us-ascii?Q?+HdJ0M3One4uZJX9RWnOxcdf4DnC7k0Nv8f6mre0K9yEXbjEfz/md1LCg/qK?=
 =?us-ascii?Q?kDKuhElz0PU7eHwVLefSzvWW3HI+sAFMBhmqUlSviVN+mPzZ880EpRo5SNut?=
 =?us-ascii?Q?xa+YDgW6JSSawZARg8Gch2XRg93yGCPzs/DGmGuihSoZay5B+8sEU8qlxcri?=
 =?us-ascii?Q?MIlltjiDc4EGGMwuLTcU87hZR6BO7s4twqOVVysat5aRBlHoxt0nqIqxU5I0?=
 =?us-ascii?Q?h37h/ikKWLJE0jh8MaST8MHBTgRjsahbfj77gWAoBT9YqLJuXgdvTW5axqO1?=
 =?us-ascii?Q?jq0fj+klTptBMlUBelM2MeZT9tKaw81tWNYUlXVRr9/r3JxhTyqQ5kHWveuK?=
 =?us-ascii?Q?3XTy4/Hfs9se6ns4+7CBUhD7SbLYKPiwN0/qTquUhWSEjeGsPqwh4mTxgoOi?=
 =?us-ascii?Q?ll9NFze5uGzNr8CE7vZGFpxbP3PVSTb85m3OyPAHvmqgZZS/Ypyw/aOvNxpY?=
 =?us-ascii?Q?DhwF1odW2vPx+FytTeLmqXq4ZpqXUlPnFaLLQKK06fon+NyeDcmf9Ho9Mmmv?=
 =?us-ascii?Q?adG49FUSFOISoMXIVukLD6TZXOenP9wU2ujFIx8/TZ1gTFgzgTFU3eH8nZPk?=
 =?us-ascii?Q?gC5GKqgaQQszQe4gwZGFa5NuXBPCDTiC/cosOOoIaGFOWJ+bwA3puyt87N2X?=
 =?us-ascii?Q?zX3GtD4gZ5xtOa/D82lPq9HrB5Vn2hvqQietkTCH02BdmPdMZpEhTTNcSOC2?=
 =?us-ascii?Q?TPug7RQSZzQ++eaC/i0P3IQCWSEuSZU0GNwQIeoQ390TrlSce5Ra2uArULmB?=
 =?us-ascii?Q?1mT7CXgkBfxpAB01B9An76z/EJv3RwmeZsQwpFtiNZtfAsDC4Ek+0aofdpmv?=
 =?us-ascii?Q?3WjKdcbTxr4jbekfYidvFWSIpqDYio7Dmi5/4xSW4il4jcXT6j84lkneaAY4?=
 =?us-ascii?Q?66zYF+CLu1tyzDBI0028AmEsZnwLocmPZXFh5QoqNQweJyJ5UalwPYViL0Jk?=
 =?us-ascii?Q?dE3o9yFzRpRJcv4raCcxxhOlc6xK/FhYzrQtsyM8ws2Ros2DB9LEvNgI0Mjv?=
 =?us-ascii?Q?VSGt3JEbOjRHNm2KjuEaQ2TuBT+gxA2/6SlEjRf5ZaQ+Sd3WPsLrBpG5/u/C?=
 =?us-ascii?Q?858q7l/h86T8lj+sgZ7TCT3ONVzDD0goetrC7j98CYZP2hosht+ZN21afMVu?=
 =?us-ascii?Q?xDnmakbRLLrQPnbTXj6Xj1FT7vi3Usj4HS+oth1Y4F/K66p657O/WmtxBn6a?=
 =?us-ascii?Q?KCap2gva6x67qqO07wo7tv24H+XOe+jhEIUirHIyP6qjV4EvzR7xnhpPeLov?=
 =?us-ascii?Q?OsvtWWfmQKWclOmHDLk2/OH67MgK48KleR5m8j97NTzuoliXFCMbnoP1MwVE?=
 =?us-ascii?Q?7A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	RKgT256wVIj3czv54Av2HK67MzCP3pre9i+MYqwTtQOBduXnwfFCuLulE2iyLcS/z+FAsgqydZoDCn0FKqK95zOQSaBMZoG6cumR/us/6ep0JgWfdBQGH42FkonTpMauJkJFWT/DYan4SnBS3ASjLl8xPFN19td0d5WO8M7CCsodre8dlr0BwUQ7dHIoYEOlosp4XdNOnUlyQ1r0p1nYA1ti3O9+FjWkOCGvn+sRvFWfJ8tCIIrE8PW6Q+N2k4fMOd9dT1v9ZOWKkwRVM6J7HN+mH6gSumRGaFkv4sTqonJL0HoaPlW9gQSRz699SGyFpJ5T6ajlpsr66QaQbhlWyM6M8t66k4/Pb7FTezPZosDCiEVdXi8ozVlNxNacVpVlN0agYxPamZf8TToHnL09gR342yZRYzSN0+2MVITiGqwqOtXkrAadbU/jpCIYqPovJfAZgUoVdL6kQx/FxV3Uk66vD1uc9wYDwHlps0MJOfdGO+1thvc72IzfVNfIh1RUZ5bKUpCd+KXee1OCfPWZUgvG9WLPaXz09pEwZAmtVAnbqwPAntk12u+RN/CM/GL+miYLPZM9W4KQSXOWzXd2ZVKSxMrWL0ehTM8Y8mz5KJw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 209634b2-4141-4497-5a6c-08dd4d083ffc
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 14:59:58.6861
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E9/6DROivgx2AADw7jQcS7f+PB4R68oJkW3x4BJqbLIWqdw5ZscC2lCbZ/daAmuwDMRa71Vc+LOr6n5g/Gxsnvys68rid18ZEnhozpfq/EU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6909
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-14_06,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 mlxlogscore=961 mlxscore=0 spamscore=0 suspectscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502140108
X-Proofpoint-ORIG-GUID: Q_umu3KvSQBth7fjKvTxde_m0aOEVO2Q
X-Proofpoint-GUID: Q_umu3KvSQBth7fjKvTxde_m0aOEVO2Q

On Fri, Feb 14, 2025 at 06:39:48AM -0800, Jeff Xu wrote:
> mseal_system_mappings() can be placed in mm.h in this patch, as you
> suggested. But in the near future, it will be moved out of mm.h and find
> a right header. The functionality belongs to exe namespace, because of
> the reasons I put in the commit message and discussions.

With respect Jeff - and I feel that this might simply be a miscommunciation
here - but this doesn't read wonderfully. 'can be placed' 'it will be moved
out', etc.

Please try to be respectful of experienced maintainers who are taking their
time to review your code, and respond politely and respectfully. I think
what you meant to say is something more like:

"I'm more than happy to do that, but I feel that it would be more suited in
a separate header, as this strictly belongs to the kernel functionality
surrounding the execution of code. However we can revisit this at a later
time!"

My feeling is that this is exactly what you mean, but you are just
essentially abbreviating this. However it reads rather rudely, which I'm
sure you don't intend.

Ultimately the fact of the matter is that your series will be merged when
it reaches the standards required of you by the relevant maintainers, as is
the case will all code submitted to the kernel when we reach consensus.

In this series you have addressed a great number of concerns which has
brought the merging of it very much closer, so I hope we can continue in
the same vein and reach this consensus soon.

Let's try to avoid any miscommunication which might delay us reaching this
aim!

Thanks, Lorenzo

>
> Thanks
> -Jeff
>
> -Jeff
