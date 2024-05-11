Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05olkn2029.outbound.protection.outlook.com [40.92.89.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171B03BB21;
	Sat, 11 May 2024 11:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.89.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715425472; cv=fail; b=cEpTv6ZWCU1QhbWW5/qzpckOIaMcp9jiob1xDW7ze8qB0qyGs4MjYzneNmws9mDi0YUIt+b5zPF5bSUDa9GLhqDBlANcoZIrgK8kwMyT1vbYhaaUG717IXWZDdYUzV26ad/7CizQh24wm/kUC7rfTSWUa+RajfqunpGqiMUC4AA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715425472; c=relaxed/simple;
	bh=GXrWHiV6HaCBazh0sqFAllou5DD0ZY4GbDQ4IUPveVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=orCEj5fpYP9AvFX2m4mIwzLgM1L+VDmeDC3iCkOXUEbLSPQ7QSLLbpelJQEDT3wmw0Y9H5scoTdCrtOmJb6g65xrrlp9/IDvoqLhT0LgmpjnVFyEtcGomR50/MhKDhpvmWQEyJY5RvVkBG/PsG3+Q3u+e2HLZ0KqvCrkz9TxIu8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=GlmTQdvI; arc=fail smtp.client-ip=40.92.89.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="GlmTQdvI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AkbAbv7vTZhe4wlHZXZT9t99D+u6dDf+GWSxtHwtff2P+ierTHB5Caq1gWj45bxvQ8gInyuyqYYIxD15GVcBxKjxzvudQumpmy10HaciOF8Dvga1LYK6tg6IYqC8CNqICAqXOL295CXEUMaip3M6wH4drKnqBSFT7hyDWCsdqHpnhjqEpskI0zhn/06a7fmsFK/CXmxMBUC8cGHc1VuXEVSIlgYlysPL2i33T9srpT+G1LbDlKjT1GNFQR/UQZ/GPp0sqpOjlE+T/yQB3FwF1VjzS99qHj0+PMIY1ilNwGk+HmBfRWLM3gqmFTVkLErMbJ8fFBIJlTDDU51dyODu+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VMxhxJ7w+TYRnFmfblJW/h03AE6CnHzwJJhZEtxaj4g=;
 b=LphN3BDHIG3wqcyb25xfco/GIWMekqPrCq7N5beT3CirCOW8OOEwhlhFIi9IUu4ySbGgzDlBcSHFnzKQWZkAvURujzRFCKOobw3G7bO/YzkXemEaui528j0EFEJ2KGEFXDC6ljWWhX07iaGNPuybjpNR1AOVsWmh27HUQb7qjD5Drd5cH28nVK5cSp+vo6HU2zG+sinubREi60IhjvTNYqByW1p5bdOVVjfh5BlKuBLHuOEL/YUdu4Hye2JVbynTk3UoWQmZJqRD6UouhnVeuI4eX+taqWRuRfXbukKJr95ik3gTABk7opVXfXF1jnfmmKbu9OUFPWTgBSarlsazuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VMxhxJ7w+TYRnFmfblJW/h03AE6CnHzwJJhZEtxaj4g=;
 b=GlmTQdvIa+nlN/tHYjmKwN+S6uy4EO9pgJe/vse8x3U3gAHOoE6q0lBXHMTuh1Ekoaf/FNCpbawdXMJILfp1Wsxyhif3zNVRtGjK7kxeME/fqanaBhb9NKJayxazItad0IVAV4Q0IThx/V2jTbfwVDqiT3juep75nSmxtybSWTOH9PPiPQtOpCXRJhw/dQycDczTOTmlB9btm+wPPei0Aj2H380z39EX5ki6/pvF7vOkxKZf/9hiTDBcVfF3Yj6CagoB2UfOfhGi9QnHQmRo41nGuNwFQa6AbQxl9u70WPbSreiX2vRLvawu/SpuonJWXAQFPEXKsxbGtMxK6F8p0w==
Received: from AS8PR02MB7237.eurprd02.prod.outlook.com (2603:10a6:20b:3f1::10)
 by AS8PR02MB6982.eurprd02.prod.outlook.com (2603:10a6:20b:2e7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Sat, 11 May
 2024 11:04:28 +0000
Received: from AS8PR02MB7237.eurprd02.prod.outlook.com
 ([fe80::409b:1407:979b:f658]) by AS8PR02MB7237.eurprd02.prod.outlook.com
 ([fe80::409b:1407:979b:f658%5]) with mapi id 15.20.7544.052; Sat, 11 May 2024
 11:04:28 +0000
Date: Sat, 11 May 2024 13:04:15 +0200
From: Erick Archer <erick.archer@outlook.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Erick Archer <erick.archer@outlook.com>,
	Kees Cook <keescook@chromium.org>,
	Alexey Dobriyan <adobriyan@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Dmitry Antipov <dmantipov@yandex.ru>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] uapi: stddef.h: Provide UAPI macros for
 __counted_by_{le, be}
Message-ID:
 <AS8PR02MB7237F03B3C7FDF92510049E88BE02@AS8PR02MB7237.eurprd02.prod.outlook.com>
References: <AS8PR02MB7237CD9ECBF7907AD8B1CC938B1C2@AS8PR02MB7237.eurprd02.prod.outlook.com>
 <e9edbd4b-b117-4876-8d3a-52dfa1d2a8f6@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9edbd4b-b117-4876-8d3a-52dfa1d2a8f6@intel.com>
X-TMN: [C1q9Bt5TMlmAVf5HJWSz67rifdsIxurm]
X-ClientProxiedBy: MA2P292CA0019.ESPP292.PROD.OUTLOOK.COM (2603:10a6:250::17)
 To AS8PR02MB7237.eurprd02.prod.outlook.com (2603:10a6:20b:3f1::10)
X-Microsoft-Original-Message-ID: <20240511110415.GA3139@titan>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR02MB7237:EE_|AS8PR02MB6982:EE_
X-MS-Office365-Filtering-Correlation-Id: 4484765c-bcde-476c-e53b-08dc71aa1eca
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199019|440099019|3412199016|1602099003|1710799017;
X-Microsoft-Antispam-Message-Info:
	AF2IQeIqykuBxV8LhsTj0dRxhOMxUSCk2eTw6mUgEqE0nxF5y2+r2ysbIhMtk650D+zwhjWDZ4/O1ouujZfOODjj32iDTK27KoXzK9esCyTJq0LPypDJnvTd009lSu8UvrXWmzVjrHBzjDhArkM0dqt606saG8VpQUGiDzNavdf9WObqZ5BixmVwliGQ5bB/1W6NOyi+wHPs6AU9QDx9RFhhRjd0m4aRWj1/mxUFc+Aj6pS26oBVbxl+g8NpW8wU/WkwgoWG94JVve61hbGjRTK8X/W7xU0AUP6Gk1tdOcU22VWJFBSEkIwDuePRNq1/qCwqeV8HXyukhgSYCGLxuiHGnlAlj+BIVvKWCUIM4cQRs6G09oW44e6aRyPq4+KCk9robxnoIqOWSqRtD0WknPj3vYBKXDSYO+86JP6VKS1ahuLHfsj7ox33u9SuJQKYd++f7qrOI/iQGosp4qZtQ6QthNAy8Kvc9BJfzbM6c3CX+K9fORKyzgkHvuuEuAn1N/iQaaa+srK8CvtzqadPIJxC9FA6fm8nrhrenjlD8mpDvbXKep8Ud53qWSnMqpKTI/DplfQqNSRtl4x4vJc7oi9tFvvb/fZKKf206Hs6NvqhdK3fGXoWWEc44DhN8XJSRPOTTFOO+2KX9MdzNG4ZHNSYpo78DSl6yf8S9C+YIxpRayzWwpAYrbRVbVae8x30
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iH4LGqNCcDgTDFz2KYjhX0Ej41RffWPBVgAnFhNEUNNEz5ajNJybIxbF2DBr?=
 =?us-ascii?Q?p3HYaQFF21vH2adYwDqNWDGGaBDWHvpEYxtns0HCQPPIcF2IT3f54T1hOIER?=
 =?us-ascii?Q?DO0x5TTTNcN/81Ik7P3sdhNzqd8/8SNwLv+Ix1rnLrs4nKGQHeuPj6LDAMh1?=
 =?us-ascii?Q?00OfgWivDyAJr0Mcc92iLRb/v5O/yERnBaFx0yJr+Uydj8nYq2JPrfa4j1ik?=
 =?us-ascii?Q?AmCgjfFfHkmEF6l6TOAhQ1f4juwFDczEmFsyW2hvUgdEh03wY/nnwFPPQjIZ?=
 =?us-ascii?Q?hvTaTeMPnzjLHozkvKJFvaqvr8AqFb5lQigjs+51eImrKycR4z83vZ+PZ3aE?=
 =?us-ascii?Q?xuHmndrgO1pTKzv1GcVIX4ovZALPs9j2j0hvTv3gtN4+jkV9L1OFfX7H+v2U?=
 =?us-ascii?Q?l7Zx7CEfyBU7sob5HleOsefAcG/KQS11nj18NOLupFca6gvjlYPbPkfKfeBc?=
 =?us-ascii?Q?fKpydBuZ7UaQZFI6tnBpOnq0Fbzf68ne/jPND+gmg9wrkxs2Y2NvYbkg77hM?=
 =?us-ascii?Q?Zz/75Tp8EsBQ5Mv/FIDY+WVmV1I91iYxIjSBLoramUt6RkUwpcvpua+xBrSV?=
 =?us-ascii?Q?llYYLzQiRIwgd0COBq6zNzUXF4qy4lB+9ja11P7hQZoxktvXSISM5hYOnCAM?=
 =?us-ascii?Q?dcJMgB0OReqwk/QXGvbnSAsQD8XKvMnsecX+khhnZ6gOYxGbukyWz9lcBOX4?=
 =?us-ascii?Q?a4EDrhzAQi0FHPWHyb06IiQEYSVUZvDrLYc2b1Gk5Y0CN/mzfPBAsmjTBQSO?=
 =?us-ascii?Q?dg6U/4jQhUvb/5MVV4Ouq1mJSyWffNMlzgD60llZnHIxYpUfSf2nFIkAgSl3?=
 =?us-ascii?Q?mWOaec+Qz5Tmlvp5di9bG+lRH22v74bCRz0MLYpMb6O+PCXeBJt7sa/203a7?=
 =?us-ascii?Q?umanYdnVaLiMl/fY0f75pGFLDojv+r76OSWEy19YUVmY7wBXVLFtlCLzQ5Tg?=
 =?us-ascii?Q?E7Gf+Z8T2MNg5ELDxdfTA7Gfo89ctkoq6iWXlK+WpNm/ysEVbjqXO5WKL3tR?=
 =?us-ascii?Q?7hFKsXtrkp9LoC6j7EmGPza81xeHi8gHMbI1wyx2woYVIOXWfUCfMqViXEFw?=
 =?us-ascii?Q?erb/7nOk3xDNLR0+tTsBDCyFYh6NC+UZBTldeJq2jKDzR+X0UkzJkZgTSkEt?=
 =?us-ascii?Q?LW9b2QYlHcmd5ofAFJYDYdWzSwxa7ntfh5upV/SQMfZtvSvty6pbnHEfz6Cf?=
 =?us-ascii?Q?oMLrAuBgVyZlAY1DTleiz9Dh0cKBSugKO25SHF2NQv2ebDVVD737pIdfTenz?=
 =?us-ascii?Q?0GYvbnpvb3mPAlPDiC75?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4484765c-bcde-476c-e53b-08dc71aa1eca
X-MS-Exchange-CrossTenant-AuthSource: AS8PR02MB7237.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2024 11:04:27.8733
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR02MB6982

Hi Alexander,

On Tue, May 07, 2024 at 02:58:15PM +0200, Alexander Lobakin wrote:
> From: Erick Archer <erick.archer@outlook.com>
> Date: Mon,  6 May 2024 19:42:08 +0200
> 
> > Provide UAPI macros for UAPI structs that will gain annotations for
> > __counted_by_{le, be} attributes.
> 
> Pls add me to Cc next time.
Ok.

> Why is this change needed? __counted_by_{le, be}() aren't used anywhere
> in the uAPI headers.

The goal of this commit is to be able to accept this another one [1].
In the "batman-adv" we annotate "struct batadv_tvlv_tt_data" with the
"__counted_by_be()" attribute.

[1] https://lore.kernel.org/linux-hardening/AS8PR02MB72371F89D188B047410B755E8B192@AS8PR02MB7237.eurprd02.prod.outlook.com/

Thanks,
Erick

> 
> > 
> > Signed-off-by: Erick Archer <erick.archer@outlook.com>
> > ---
> >  include/uapi/linux/stddef.h | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/include/uapi/linux/stddef.h b/include/uapi/linux/stddef.h
> > index 2ec6f35cda32..58154117d9b0 100644
> > --- a/include/uapi/linux/stddef.h
> > +++ b/include/uapi/linux/stddef.h
> > @@ -55,4 +55,12 @@
> >  #define __counted_by(m)
> >  #endif
> >  
> > +#ifndef __counted_by_le
> > +#define __counted_by_le(m)
> > +#endif
> > +
> > +#ifndef __counted_by_be
> > +#define __counted_by_be(m)
> > +#endif
> > +
> >  #endif /* _UAPI_LINUX_STDDEF_H */
> 
> Thanks,
> Olek
