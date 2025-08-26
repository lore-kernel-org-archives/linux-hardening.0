Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011039.outbound.protection.outlook.com [52.101.65.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39530242D7B;
	Tue, 26 Aug 2025 13:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756213750; cv=fail; b=MFyFMXOpp/SBZ+vyJIbUEsO0dE6rE1Pe9VH8bq2nBYIme9GC+BRCjN1lOK0y6MAv/hULVb4SkYHJvh7bBTUFRf/vF1TR27Mo9bcTQaqHhGaDglig2gIT6vQoXgopU4h5lEzc5JizhdLYfJAHiRwC2Bb0y5qvqkHPbk8BGvStbYI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756213750; c=relaxed/simple;
	bh=GlfbX8yuhgQnFpyGHV/3sdTrqFX5kDDGHEfZ6Qxf2rw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=bM8GIBDBlxopBTJjPG9sSkBYAyed2e9IMX88LwXTIK+rXDZALPKALY6dPgReGtAXOoWdijigb7GiSbS2X7u7J2/NrBiq/NGlrnfQ/ZUSwpIsDm36W8ZI/rNuhsc6iSbAfVuORUZWxKB1UqRzFQOs+xBYA0rQ9jy/E+1jtb4Ax3k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prevas.dk; spf=pass smtp.mailfrom=prevas.dk; dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b=L9rFG3SG; arc=fail smtp.client-ip=52.101.65.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prevas.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b="L9rFG3SG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hK1tIzUHIK9o0DJV77nXPgezjcY3hdTSfzu3WYKIXPOw5l0a2E7TZqbiw5E5tKRr/sVr4dKtUCV0K5B0wBz/JCxTU50hZQKICVNyEjxSY3+Sr1MS7L/ine02LqDTDeouX8PR335ns0tidXjjBeZl/qofLFi1rJ7OJZCmYjNVJUo4mLEa+LYMV2ISS05h0RYGF2/2ZNzPIHgybSEGDqjOUR8O63wziyuXEPPL8YtUeDwaxItOLlDsvwdB6/GEb6KRRBT5i1ddIr0N5msHLc19Wgl2ybB2MFXSaMFGrFFknnJG+tAwBv+6OsyVjAMj5bSNM8aZSowbOmyIir72dr/FHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZWyziYCGMx32KENWDGfyxKzjz2pCWTABvqKGw3nwQ8I=;
 b=spl2woSlgYy2DMtHoDZqgBD6NY+sQBtFStxTNpdPlY2+n+K1Z/eULqlr5DkGu8KGnS/WnDhbcPN1Rjy2zKhC2bzGwh6MMj7A6cD86HOT5/+7vfZkEmojYep152bfTUHP1jLxH2XkTvHBEgnZRpvARs4fIzt45LSCNBZxqSWjPUIBWcFHT2tTdX5zM+drpVO2Z3lT5uESe0A4Bp4lQW/YIk918Oe6AHrGIA29XUA6M7NMtjPuaQ+OW0tT5ezO8zNqOcjt4wf+icLlWXoi/0rX/0n5SOd73ZHmFEHFJ5O17mPfKq8an6NnOoE+hQbiai3hudDaDv0BOP3VEdATj87Mog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZWyziYCGMx32KENWDGfyxKzjz2pCWTABvqKGw3nwQ8I=;
 b=L9rFG3SGKZDhIi+e1Yh4uI6sS7IXpoYesq6IvHCAuj0JkgeXfCKC7Ehme2PjC5YmtgakQQh/8CmaWwLqVdFnthkNc1dsNGZTI4Aeb3tONFesLpqWHmMvGWYF5bjht/W9h6ybr0N7XkQ/jwfOTb+xBD+sbSGhNEyr+uvECvpDIgE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by AM9PR10MB4007.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Tue, 26 Aug
 2025 13:09:02 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5%5]) with mapi id 15.20.9052.019; Tue, 26 Aug 2025
 13:09:02 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: Kees Cook <kees@kernel.org>
Cc: Yury Norov <yury.norov@gmail.com>,  kernel test robot <lkp@intel.com>,
  Vineet Gupta <vgupta@kernel.org>,  linux-snps-arc@lists.infradead.org,
  linux-kernel@vger.kernel.org,  linux-hardening@vger.kernel.org
Subject: Re: [PATCH] arc: Fix __fls() const-foldability via __builtin_clzl()
In-Reply-To: <20250826034354.work.684-kees@kernel.org> (Kees Cook's message of
	"Mon, 25 Aug 2025 20:43:58 -0700")
References: <20250826034354.work.684-kees@kernel.org>
Date: Tue, 26 Aug 2025 15:08:59 +0200
Message-ID: <87ldn644d0.fsf@prevas.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0031.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:b::19) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|AM9PR10MB4007:EE_
X-MS-Office365-Filtering-Correlation-Id: abbc10d5-283a-4bb1-f375-08dde4a1b9fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+kHPysojTRvYYl3hTVhZE0St3JTHvuSbkKhroAN4sRHByb3Cv3tzSmBYji/u?=
 =?us-ascii?Q?T2CNfMudFYmKOWVrIzRT2JePsoXvuQ81I9DvmBFy1dTezjIDkbEZq5fKpjsL?=
 =?us-ascii?Q?eqPZM1HocVZh7eTbh0bWL/pZkbiYFtyohWuxqDLjZVf+wsXJtc7gAy/bzADC?=
 =?us-ascii?Q?RXgkByhprDhZXEVoUD38Caq/Ws9JlIze9Gh+Z2ODNZTL1zHZeZtkRpnuvn1T?=
 =?us-ascii?Q?WJLvLRYCullO01DrWdcaHN1yLBOayap1mqvC10lSZ5YXwgkW79h28GTG6DYF?=
 =?us-ascii?Q?Oq0h/uRwbPOx83cNdgoRgMrk4nRF4js/VZxKAStixpK7i/STEAnP9JFfwQSd?=
 =?us-ascii?Q?0mULS+AFWe4yYxm1U/0TluwDa010JaeBn8MJ6IqfC1nzOj2N5Jiaool2W4k9?=
 =?us-ascii?Q?TgaUvssk5w5pYKZXauE5Pzy5krQpgiXYlbcEObcQX4P6nKVUvjm0No7gE+7V?=
 =?us-ascii?Q?qgwsDMqrZqJPEkqkCwe3YZVoOhA4JGVOkrjLOLMKJU/fBaQbrkbwmmYgKWiy?=
 =?us-ascii?Q?YRkq7Ty3zEZnIR3IJWdouqnecYCEjUzeXAlDKdd1ulnGqLgLJ7XprgUQXigh?=
 =?us-ascii?Q?LIOUQlOOpFKs00n1n7AMztSqA/7c5xdH3cwIgfC9Acd93Vb0uIsm6Ut6yd1u?=
 =?us-ascii?Q?HRjVKDvYKlvGdfeHU2V8R37L9Jo3EJwxGWQfi6AmdqmZdSodAe/ctHe3kzx/?=
 =?us-ascii?Q?b1fs5IpIEzQtaFGuFNnbls99rBrOOAFz+gaSUH5jkr8EtfxA7tKSN2lbbTWK?=
 =?us-ascii?Q?UJnZlC8r55Eh9L/uKRRr4WMO7k6jVC/V6YnKDatvfLazLlaMQlpaSkl2MOJU?=
 =?us-ascii?Q?RcI1OOr0aYJaJyQKZ1CkvoKsb7SKbkdAl9RnZDaqxQBOoKUZj5/3G4xvGH6p?=
 =?us-ascii?Q?F/qtn+TKbPW/l2Yatb+AANBj/QUaDqY2+oFXScKuUMAA1RYBcq4lp49T6+fN?=
 =?us-ascii?Q?T+vlXgJQfB6727ItDfvHm8bzo3lc3crikpgB/4EMDfaqEU7fh6etEA3Jzth7?=
 =?us-ascii?Q?Li25gvxkSS5U01LfbZLMVXoI5i7dMAUG4myUUBdWvitVtXPeyeqgiawQ2yQ2?=
 =?us-ascii?Q?Dn7/MS15JYUPp4cityCcchd9C9RrNCgJzwRLq5TccFZQQDyLFEbXtmhhQNKi?=
 =?us-ascii?Q?N5eBsyXgmV5G0AJcHFqs8F4rcUZghBBS2AVFkPRmcc5h+FdPhAa5xlE56yux?=
 =?us-ascii?Q?a/6C4L+4JQYm4Rx0kUPKxVAHSr6TKPCYXk/C/rqIRvayif6GRV8TtONWQc5+?=
 =?us-ascii?Q?sl+mE5y4D06aNVlZrJUtGOW7Hsm+6C2DLToO8AkOaGhIRWjT2gxbTEgNmL4t?=
 =?us-ascii?Q?+XYV45doN9P6zexxANykSDTSRHeZukVco/Qhf1lz7KMjzjDGbXAIGF98O3Ud?=
 =?us-ascii?Q?WFeGtkIKschPXq/OgpKZjbMJ6BS11nSeWGWxs6Y7iw+gwfxmtyjLM4pHH5tu?=
 =?us-ascii?Q?FmjNXhrRirK+7y2mvqqlx7mJxU0lp0DoXGFxmcuKE1D5ycgEZ/zCCw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xW76zOUzntT89F2whPgE9st3I2xGehtyhM6+oS1sw66IiOUK3IeijKc3BmgJ?=
 =?us-ascii?Q?QsMB8UBa08xNeHo6UHCMJKkGZkDBbfOfS0Gov5iyK1wz1nOD5D9DaSqVozbM?=
 =?us-ascii?Q?54TdYyWXts9F4BZkoGmMzOeiMDC6Hrl+jQMlcibarPvj5oJSY3Q3nctgH+li?=
 =?us-ascii?Q?5IYhz3/FadW7BTKcsyLxC2EjVlAYG69/MHujki8SDTebgZ4ZtqYUSh52Rfos?=
 =?us-ascii?Q?Nn/JmfAYmvT3ug/fOHapyHaU46ZeRvc5/G70SihAmjIloMVcHuAz1y1ySclm?=
 =?us-ascii?Q?AWDcktoXIdFWvNDCDgruv2EmFT6ee17dW1Fc05VJw85aSCj7oKEbY77JoeOF?=
 =?us-ascii?Q?d9VQjnYINKW1J9czBNqiKBeS9/d7fq6XjJW6lrdlyKqirHJXDN4FpT+Sh8Rk?=
 =?us-ascii?Q?i5zr0S9W56z5wFu8s009q7AN4PJ+DSL2s/llzTGHm24kdDc5eeLattbOK7ZH?=
 =?us-ascii?Q?/BUXcm0SCynn7SRNtWq+vXzhJJZDmQrGXVScl2iyETT+ag1Nrr832BGLyF0z?=
 =?us-ascii?Q?Ttyjufsw/SaQpUk9294yHjlCWHGZ4aq5qOlROHKQ1de/mOv4ekZRit6mwqpV?=
 =?us-ascii?Q?OO4hHJ0ixny8bVXr3R8zQb6nQmn9B89G1xTZYKp9IpubVE8PbXJ8iGddjahK?=
 =?us-ascii?Q?PUCHZH8O1/ZiVaL9F2UXPe8KTf7xorU3FSaRHP5Ppl3CphjPhj/NKkN6W95I?=
 =?us-ascii?Q?ec1Lqjz4h9jsrxlA8wQ5MIBddVqfTvHfQYrxhkzNvrFLCufsoD4Ndx4XjRz7?=
 =?us-ascii?Q?Z2o3SEIsX95Hpn6Ic30IGrXJkA7i35mZclMseDcIH8rQ+4UZxod5x+ORHRHy?=
 =?us-ascii?Q?Q4SIHCXDAHsa6tcItu+Z0fxMaFZ89b4jkDLRhI795RkT5IimGhjzPWxvO3H/?=
 =?us-ascii?Q?+g2FyVxgGc3Utf1Pcr6thGF55VaaX+mqlHDjonfsyYPEsKQGPg8wlG2oE7rS?=
 =?us-ascii?Q?Ji0I9+iTaNVqiG6/W4l/5QRXNm73FVHsc3+4ZIpk0JF0aPUhGYeCq1ZTvR9H?=
 =?us-ascii?Q?1MB3ga0utf13Pt3q4bdisLPalU8vpKVkzsIlLao0fOcW82x5mFnjgFaN0+t/?=
 =?us-ascii?Q?Ka3K0wPjIRXUJzmRvZWPxuPI0c8h9hcdD/ZRoygu/qRdLPURaN5xwRK6Mcf5?=
 =?us-ascii?Q?DmrPBF8cdv2IT68jbYoxfY7Oia5SmdDi5TpXQfgBF08Off3kPq5oefTn9wPL?=
 =?us-ascii?Q?IlxhCEHCixPrTZloSOZUR5vga41raTiomzvreteCe/sl3N2Nzlv5DxsqXYXh?=
 =?us-ascii?Q?rvMQfEwZCtez08JCaz3QcDlZ5XE+Pr1E1dIkjSi9lzISdwANI81ZOeumzfhs?=
 =?us-ascii?Q?rswOTI/BLD8Zd00VFHTMPtMePt6ZnrsSFpSI5YVtDfkgkrHP1iaNdPomauzc?=
 =?us-ascii?Q?K6LuBK1iC8Qo86A+BAmA5+cQymuzBslEuO28W6D0v8crylduA1rpladCwx11?=
 =?us-ascii?Q?lKLmBnKY59UY391XqKeXuKnmEEWmQLx+K45qPq+XmbMuXBf8KVsZTimwui5J?=
 =?us-ascii?Q?aDMv6+LuyReSCIngRBDTf/yp8ajejE7AXUIYxKR4shRVn891FZAbz9bihQxz?=
 =?us-ascii?Q?K8l0dolXfEGixoOncPktEsp5/P1qfRY7yVYtj7cdV+AnS2IP8o+vSLByA5Kv?=
 =?us-ascii?Q?cw=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: abbc10d5-283a-4bb1-f375-08dde4a1b9fc
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 13:09:01.9623
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LjB0eyhkhELYiXOvBlFLt6IVn8bXRz5pVVXTlLR4SAfUYSJ8eaOOnCdhAaTYpiF9nnnACqBF/LOl28xjFokAUpueF3Pyx/9CZiAKvvQXJCk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR10MB4007

On Mon, Aug 25 2025, Kees Cook <kees@kernel.org> wrote:

> While tracking down a problem where constant expressions used by
> BUILD_BUG_ON() suddenly stopped working[1], we found that an added static
> initializer was convincing the compiler that it couldn't track the state
> of the prior statically initialized value. Tracing this down found that
> ffs() was used in the initializer macro, but since it wasn't marked with
> __attribute__const__, the compiler had to assume the function might
> change variable states as a side-effect (which is not true for ffs(),
> which provides deterministic math results).
>
> For arc architecture with CONFIG_ISA_ARCV2=y, the __fls() function
> uses __builtin_arc_fls() which lacks GCC's const attribute, preventing
> compile-time constant folding[2].

That sounds like a compiler bug, or "missed optimization". Looking into
the gcc source code, it seems that most "generic" builtins (well, those
eligible because they're just math) are internally declared with that
const attribute. E.g. there's

gcc/builtins.def:DEF_GCC_BUILTIN        (BUILT_IN_CLZL, "clzl", BT_FN_INT_ULONG, ATTR_CONST_NOTHROW_LEAF_LIST)

The DEF_BUILTIN macro for e.g. avr seems to support providing such
attributes, e.g. there's

gcc/config/avr/builtins.def:DEF_BUILTIN (ABSHR,   1, hr_ftype_hr,   ssabsqq2, "__ssabs_1", attr_const)

But the arc-specific ones in gcc/config/arc/builtins.def have no such
infrastructure readily available.

Of course, I also don't know if __builtin_arc_fls() is even eligible for
the const attribute (I don't know if it might have some side effects on
a flags register or something). But if it is, perhaps it's possible to
amend gcc's builtin declaration by explicitly (re)declaring it

int __builtin_arc_fls(int x) __attribute_const;

?

If __builtin_arc_fls() simply doesn't qualify for attr_const for
$reason, I think it would be good to have that documented in the commit
msg. If it does, I think a gcc ticket and link to that would be in order.

Rasmus
