Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2067.outbound.protection.outlook.com [40.107.103.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3FB11B3957;
	Fri,  7 Feb 2025 08:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738918514; cv=fail; b=apueFl+syGfqtNZl8XU5Wa9rR2N6wdxL50PR69gCioV2FJE1Zg9DN1yr/uZ9fPFNYVmw2jefxPfq27QQZRM52RCKPZ/7QifCFUTI8taKBNT1DE2MJYo32kWw93QU2u/4tGpCxZ7gz6+nGv0zOoFrkjiqcHxL7HKvMwRuzhoPmjs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738918514; c=relaxed/simple;
	bh=4v/jvPw1nqqSa8vawSk26YngSKlTIqUrp473eS0CYRg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=bCa0noc7SAYZMWvqvPYx3UV3jUGeMh/l371/VBvpnsKEoFM4u5wn8UNXsHnyX2UIUIZ7CqfWRsQ+3CGoHyjmVv0+fSSrTbaw2M1LgmJ6/pbmMHsFYx9+BfTudCq5+hBi0QZjYStDJQeNf5XFMIyXY7BvSuhtLeXww/5+LNJO9ew=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prevas.dk; spf=pass smtp.mailfrom=prevas.dk; dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b=S19Sg0Su; arc=fail smtp.client-ip=40.107.103.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prevas.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b="S19Sg0Su"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GeerkbtOhbsr4srLGJQ8taLLkbKkdQuzetdd108IZfRCBcrqOSmLnpQQcAMvt5oJ5k4kAAVgClBz1wTyCCwiYcHu8eyQmgf/G+1VwDs09IhAF9pj3ITGqWt9UaOaZ8DO9caU8utIhI306hM6+e1SULOshqiFmqg6XkmFKW3Bg5rEroqwUEq6JFz6BanEyWRFk8AOKD89J7EdhKivStkfHiRJQF8ZFnDsGnfJfPIBmROI50ft+fBRXqKkaLhsCKhY9k8YoIVwe+q3pMFXCWHlB7/R5r72aSfVfDPj9uTiE9etBsf0jFPmiMcrFtiKj/vQY7h1iJKkUxRdpscsLT24jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DkbGHCyM022nJcHjfiXy3hh4pTmh19We2ye3cQKArsc=;
 b=oGz6pCLMbtHKdmwx48G/JPJiajnxd0utCFNuxN0BwIjF6Jj+LQ7u079BJP4bT41sX3TpDbEzpItVNi9nFJkj6kAzU69UkINSzjI9/kpT2034DLsBoIqQGHAf1qaWUDhr7HlSGTKy581a7KnL5s3tUcEX6bSqylY+p9VYPi1FByofbGIScEDwRqWoSDdOoUFau3xSbOA7oI/Sj/jk44Tl++uaLmZ6AznJXncCIOQAI9jQiBRzsqjyU5atlStp6+DpMir8epME5TZ4+WfVchTQ16h02is3QuxYMtAK4z0ANSIetDkW91HVPiJAS//EScJmcZFm111AfQq/6RFZBK6BqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DkbGHCyM022nJcHjfiXy3hh4pTmh19We2ye3cQKArsc=;
 b=S19Sg0Su0HeSW4TPvNS9u72jZwNDgL3LU0F+C/7cUiv2yCGymz+UiqaSXakkXsEU+5vckYz9Jah5GtWet3I4um4Cx+kY6yzIrMgLdFlfRM6ROqinIpTdIR8s82xB7yLHCKY5U0oVa7uTx+wGj0x0iINsYWNZfBeBtvpzohHt/gw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:41::17)
 by DB9PR10MB5161.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:331::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.8; Fri, 7 Feb
 2025 08:55:03 +0000
Received: from DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7e2c:5309:f792:ded4]) by DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7e2c:5309:f792:ded4%5]) with mapi id 15.20.8422.005; Fri, 7 Feb 2025
 08:55:03 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: Kees Cook <kees@kernel.org>
Cc: Suren Baghdasaryan <surenb@google.com>,  Kent Overstreet
 <kent.overstreet@linux.dev>,  Andy Shevchenko <andy@kernel.org>,  Luc Van
 Oostenryck <luc.vanoostenryck@gmail.com>,  Nathan Chancellor
 <nathan@kernel.org>,  Nick Desaulniers <ndesaulniers@google.com>,  Bill
 Wendling <morbo@google.com>,  Justin Stitt <justinstitt@google.com>,
  Philipp Reisner <philipp.reisner@linbit.com>,  Miguel Ojeda
 <ojeda@kernel.org>,  linux-kernel@vger.kernel.org,
  linux-hardening@vger.kernel.org,  llvm@lists.linux.dev
Subject: Re: [PATCH 2/3] compiler.h: Introduce __must_be_char_array()
In-Reply-To: <20250206181133.3450635-2-kees@kernel.org> (Kees Cook's message
	of "Thu, 6 Feb 2025 10:11:29 -0800")
References: <20250206175216.work.225-kees@kernel.org>
	<20250206181133.3450635-2-kees@kernel.org>
Date: Fri, 07 Feb 2025 09:55:00 +0100
Message-ID: <87mseyrv6j.fsf@prevas.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0078.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::13) To DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:41::17)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR10MB2475:EE_|DB9PR10MB5161:EE_
X-MS-Office365-Filtering-Correlation-Id: 43f5d92e-c601-4e61-d665-08dd47551c73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|52116014|376014|366016|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qAc7/tJu+LmxQonboAIezPdgDqBGQQJ/+7xBiR/6iqMeFe/ee10cg2PN9WN6?=
 =?us-ascii?Q?g9VFPFhwev9zNcljso8Q6O0XiV2ek00r7/gU3kSyxjYx3uTs2/ivF0Q5RsVT?=
 =?us-ascii?Q?1LGT2bZHiXXIyzX3oD8XuHUK8ifi6VgCRwI5ozANcmjmGJ7PIzmExwRrvlG7?=
 =?us-ascii?Q?gZwxzn+jK2Gy6e7+L2Ya8ijNPQSiIoJ3wvOYWJNeg3K6uUgOGSh8Absk36TC?=
 =?us-ascii?Q?0661XOrvexjMLmGudfORyiIvXiHaaUNZqYjxOBfjpWON5sRGLRqPrxj7BzWs?=
 =?us-ascii?Q?uLI4mkppXwoDnQxxlkfRpi+1sS2lWnj+Jfd5e8vbb3f7avmLShaVj2QZjoA7?=
 =?us-ascii?Q?wiSxXdWbYg8CdGJiNYX5P1vTUnOMYfzvO1AruMt6pkecMZViDcjXvb9GlmdD?=
 =?us-ascii?Q?n8VM919fByMKOlfmNV8N9yHDa7SZLOq7LKE+dI4kRHFEC57Vz24fIboOoQuH?=
 =?us-ascii?Q?u6oIZSBaSiUb1RwCoRhsdDp+f9EdP9MMdCOu0cAW0MWzaflxozTYJar01ju6?=
 =?us-ascii?Q?uM/OHWTy/Azll463qqXgLuMJKLgAJkUpBuzvYo9oUlsSZGiky00uOGBtyofg?=
 =?us-ascii?Q?gwOK+5TJKQ3fk+0NONCnCbKi1cmBPCpv9SrVvMjgKTJVOuZMiHwun9cOnFwM?=
 =?us-ascii?Q?H54ZV34sv7KsC1+Ti58Ha9vJkHrR5j9Nzl8l3cRD/QMnT4PFbM/0GKN45Foy?=
 =?us-ascii?Q?d/7tVJ98mCt+1JTa4gGRNGvfH7/x7YHQQnBqRhDMqxzBkg3rmcAbkaSZ8PZu?=
 =?us-ascii?Q?ru4xXoqhnPK4MuI+jnxVUe7IJrI8R8Q5547AhH+9F/icIVcB4yve4zAbTfgY?=
 =?us-ascii?Q?T54j6LveUQL+2GADZco5atqj+hfmPkweDYFEziD+FHy4CezgY5sMqQwOyWK3?=
 =?us-ascii?Q?D8YA5Ebnx2nuNEkbsE2pBwVRJYffJQiw73PPWlpCfMf3ONbYjbZKuhsiiMA+?=
 =?us-ascii?Q?r9k17vqzkn3gYonqyrCvkDNN07/pYVblyeDlqSDlBY+oXldrq47PX67qOfFp?=
 =?us-ascii?Q?rGOZ1D55QcNGcQDmZOKdwRhMpukvmTkcTTNNi4Rov6nMTG8dzpGBjbWeuMUL?=
 =?us-ascii?Q?4JBD7owE05Jt5wjhna1reQpMcRdl3mPVW+/Qvc2Lvf35OQD+axx6g0KUrA56?=
 =?us-ascii?Q?crI41ToguM9D/BZT/gFEwnSnmivcvvrZi3f60IpACh6YbEc6tVEFNHY8xvfj?=
 =?us-ascii?Q?fTZjhbOkjqmtHBrg91Ta3QK03CFle3PzJQRge9zIMwP8UkbJQNfseWRuz/zH?=
 =?us-ascii?Q?vdabUGngKbI8Af7EWeyhWxen6dB/Z7WdHXfK3hGhV3S+URMGH5gMWKpjFlp2?=
 =?us-ascii?Q?eRSqfjzgxx5/DQE9DYjQryKJHokaEOHww9KXWNQV6AJf4BV7yAsC/b72SgTM?=
 =?us-ascii?Q?cQa7UbLxC6otmjMTgSdwCgHJSuFNMH9+ryfYQYgz/9uI56r5fXp7UsEGhWvM?=
 =?us-ascii?Q?ueyC3g1soO4SuFxuQsSTWHYqnbifRn9r?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(52116014)(376014)(366016)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ad5w4tpo2k5bzsW2ezB5YfCHYLO7PQiEECDOGzjJuxTv7kCI65/hsB0jUxSY?=
 =?us-ascii?Q?goSDFZdAjWcIay4aAhB20/6/S5Dx1bKZllDylaFVAFflqHuQj+B/fe1byXOm?=
 =?us-ascii?Q?5Pnev6CP8BEZnraiPaQvF8OzAYeKwz91N57T68bsw84JE5w/KJnsNqvLRb2i?=
 =?us-ascii?Q?UcAj9v8q/zaE+nMiz0xj6dgl+px0qrEVKOoq5xTV57yzC41aTsE4e44YJqhQ?=
 =?us-ascii?Q?2EB5Zrq+6PQ5M4AT1b+2bikUfSIYQD8+w0QdYnbfo2jqqktTOei0LF1G24E6?=
 =?us-ascii?Q?pLdT4A7EhmkKhJh5wKCH/W+gxGiiXkB9cN31+KTaEOvmI3D20uoXrfFqEAKe?=
 =?us-ascii?Q?ztFBOZjBWYqUatXWk/JhSAVA8ztdM8AAAVJRnGY/dh/+WGfK+EjixT1BuEge?=
 =?us-ascii?Q?0LSS+tnGO+47hsWzy6F7N3fuduYWLkiu8+Ymv6lYsn/RTxyM8ks+Uxbd5xXR?=
 =?us-ascii?Q?CJQReQInwdNkaG3KzoveRm5YTvQCemnuuW4q5DvLcNCZ3IW0bz/39KpIC/GO?=
 =?us-ascii?Q?39zdHZBV5IUFASUsfEsKWM6R+hRXNj0/8+OuKNKSswI4Krn332bka32/Jtul?=
 =?us-ascii?Q?vAKr3wcKc+zBua6KJUj/rhWBQrGbRo+/7Q6E119V78fwejEwzeYWsu/MDbnl?=
 =?us-ascii?Q?FY6P0tacPju2Kor/ffyrd6coVLU8SWfMf25tMZr555jXgUWvYgXnIwt4P5Gd?=
 =?us-ascii?Q?2LSkBw6txQ91ZrfG9y8yvH9cdtghKuZbTatmO6U2iSIcF47DWfsSxy264bDS?=
 =?us-ascii?Q?E2ttE3ESszlBbN7RJ55z7imSyiGSTlR2h6KI+oWOpDwIUJQMKgODKlmZezgf?=
 =?us-ascii?Q?PnsYDXiEsddS6xS3jwV7IrL6uJZbTXusm0NdjqBjWrmWXFQ67AsOgSFdKsc2?=
 =?us-ascii?Q?gg2TTrG7Gzg3I0zc7pMwGOAVMBII7IG2Qkec8b96z7Uzw1JoT/X5FmJZbgHM?=
 =?us-ascii?Q?ESL+20vhuVm9KcVMmf5e4fHu4g2Yd8umv1gEYbz9432LosZeMTJx2QOO4T1M?=
 =?us-ascii?Q?w4g2HQnu3xtqXZUq9JvdqsRdVocxivySgkj74OzTgIaryKMMiyCpuQpJc5w1?=
 =?us-ascii?Q?1oa/TZBW/55IBAkgT1OlfoQbILF0BQ7y0u81qlR3UxVaoMq9NAVW/Rx/WbYY?=
 =?us-ascii?Q?VFvISlbQG8hYe/4m9uUvTf+CoERsZiTfTu2ps5uZXlc8i+PI7BcEFFnnfSAh?=
 =?us-ascii?Q?r4C9/j/qLm7oBEfMy5a9ZNQ4NfeheWPh/xr7H7GWXUSxpyDrEfl2zxlXziSX?=
 =?us-ascii?Q?6BDPqXLrnGwxEsYIOoJGUb185LXGXnJGfC45PF4wCARQFjA7n+9lglKs5QI0?=
 =?us-ascii?Q?9bBObXQK6Mus87ZOTa3lhVJ8LERwoK+HnvKFcDP/VJ724DiZoIbCl+E5Tzim?=
 =?us-ascii?Q?AMWBYEjCo12n+dvRgioUxh/TxLf1vPnbo2/1ZIDl60uqBeQlA6bqOuu80g2F?=
 =?us-ascii?Q?4rByhBA3YuMQ9GFpgtVxnk+1X0mnZDJ7Lk1L1ELxnzc1J30YJhAPqa2zmUUS?=
 =?us-ascii?Q?acUaTeAoQUeUEbDwN+EJtMfJmu/ooUfTZw3TSQI161dnYG8Cv6bYa1L3VncS?=
 =?us-ascii?Q?RzkgrKlBO+JYCN9N1egrvyAiuL1rAwB0IaG9P3RBg6L1jI/dwbSfoaqU7W+H?=
 =?us-ascii?Q?8Q=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 43f5d92e-c601-4e61-d665-08dd47551c73
X-MS-Exchange-CrossTenant-AuthSource: DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 08:55:03.4138
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: soCgWNm6cfNI3pzIJneXlmgCuxMBAZWbKn2Ys+YEtpXfPuEwGBQXTQ/BjpDuxPA+Q0WpPIglebPmBUHoenFxU5DI48A1srahtjD6NuRrwGM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5161

On Thu, Feb 06 2025, Kees Cook <kees@kernel.org> wrote:

> In preparation for adding stricter type checking to the str/mem*()
> helpers, provide a way to check that a variable is a character array
> via __must_be_char_array().
>
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
>  include/linux/compiler.h | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/compiler.h b/include/linux/compiler.h
> index 7af999a131cb..a577fe0b1f8a 100644
> --- a/include/linux/compiler.h
> +++ b/include/linux/compiler.h
> @@ -221,7 +221,13 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
>  #endif /* __CHECKER__ */
>  
>  /* &a[0] degrades to a pointer: a different type from an array */
> -#define __must_be_array(a)	__BUILD_BUG_ON_ZERO_MSG(__same_type((a), &(a)[0]), "must be array")
> +#define __is_array(a)		(!__same_type((a), &(a)[0]))
> +#define __must_be_array(a)	__BUILD_BUG_ON_ZERO_MSG(!__is_array(a), \
> +							"must be array")
> +
> +#define __is_char_array(a)	(__is_array(a) && sizeof((a)[0]) == 1)
> +#define __must_be_char_array(a)	__BUILD_BUG_ON_ZERO_MSG(!__is_char_array(a), \
> +							"must be byte array")
>

It's probably unlikely to ever encounter an array of _Bool or array of
structs-with-a-single-char-member in the wild, but it does seem a bit
odd to base the test on sizeof(). Why not add a

  __is_character_type(t) (__same_type(t, char) ||
                          __same_type(t, signed char) ||
                          __same_type(t, unsigned char) )

helper and write the test using __is_character_type((a)[0])?

Or if you really mean that it must be an array of char, not any of the
three "character types", simply replace the sizeof() by
__same_type(a[0], char)

Rasmus
