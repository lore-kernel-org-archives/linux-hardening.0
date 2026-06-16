Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazolkn19012056.outbound.protection.outlook.com [52.103.2.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5EFF36C0C8;
	Tue, 16 Jun 2026 14:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.2.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781620080; cv=fail; b=DAO9apKT+bRuh+PxNSW5//Z+1A094bypAD0BSjZsTYLN5DWJqliddhnJ7MpPQtLB4I4J6TR0uBmYUTnU9vHScpABjC0MbZqsm8PK3MaMZdGnXa0fsNFSq/wpV9TFY4IAcXU3cPVo8OwRvLSllAOufMCWJBnoMAQfanwAazn2sYY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781620080; c=relaxed/simple;
	bh=bfnUcm0F3PRe/TgHdfbgvpvMhP6dKr8BLq6EbSH3DYs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hh2kaX33L0VVioPCL9hMce1Xf7rhWfKiopdLV/ze/75wom6OQYJZhof5oQmWsnGqKbg+9li9Wtkh48bu0vqlGP3dwEoBQSV/5vV9PkMSZeytySewS1EjyTegMAiU8QJVSTkE5SHo2oFTmpW7iTdwy2GeeveMrTqpZXYGSYwiC2M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=NnWlfJsp; arc=fail smtp.client-ip=52.103.2.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="NnWlfJsp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KjkiSDzmLIurf+bPfKtDPlzLNwWr6kJNXTj0tBRPWVRsVSupUyG0OQm6TbMI5temr8Y7Yn5BmkBedujRkA7hUalgS02WYwhTQcEO9E/upVuWo4NTQi1vlwSfdAQrv2qqZZaNcfuW8ZG1npXLrD3zQ1C6vDgU1DZdXIW7mFEjYHx0+xfiGdDkn/h2HSSH70gYV3qSAVRCEIT6vqkdEr75Rstzbqxyf0s8/F6ZhQZERG06ETmauWYFJsN9D0sg6Z+4SxywotJKWk5taUQidxKPJEtW3EX6ZRSUk6SF6KzVj3Ng8kBXJgEyNMrskJvYr+1XmQeRo4lKAyl5G1mp6+Yjsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cWxyUb0/iE6N8LUl0gCPNeaW4iSRe5tlcSKpglIzQ3w=;
 b=JqZWKoggz+OBklD5bjhEMLLldA/3WrgJ8vcsBybbMH3pCfnKA+naC0tww0snba9pZm5RXSo6ZJMsjGweXCMi5CONe3K5ilH3bhjIG45TYmN5425uCP0JDdAXA/zY64M4nLcwyj2v3LsmAOkzoCeKln2bIkuo9v9qcW1qwg4W9R+/xQ542uFRfGOpXF6t9nUWE45xr0u1aXFuub7U/3zKMuzaeVjpOHDqz7b9fGxIkglHrmNGyBs4FPl8XKu6g/DHbJv0xs6sReO16Wfr4yHYvZO6mHG+QY1CRlKvVY32tBNju7seQGqlHZqiRnYi5ctZONFpn0zl0oppUfCmmdotHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cWxyUb0/iE6N8LUl0gCPNeaW4iSRe5tlcSKpglIzQ3w=;
 b=NnWlfJspUWuZZXYIbFhm7wv8jeQenGpz54gbKhxzgIQQTuSl2RXSMbOnDekjBW8KEzrYY94zXZTc/881aSIiEaXv9zaHTRWXmuQIEEak+oDz4AtKAVOc1JFOr/if37kheJdlmanvAkbHXOGNwOOhMhyT7jXUAtE3JV+jaSqPvcXjTi4/evW0LBN1MdOKzQ5JCGc7Rh7BHwU/ebamFRA/uWL6vaxqeeuH989ZK1UVKtXONisVpVkeFAk4U7d/bbdusr6IhKmJ+WFyD0NoJstWOZG8AG/lIxhVuDGGH/30COup9h38vgQm9LnIaJp4QZadY5pJULohNh5QU8VpF4a0nw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CY8PR02MB9201.namprd02.prod.outlook.com (2603:10b6:930:9c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 14:27:57 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%3]) with mapi id 15.21.0113.015; Tue, 16 Jun 2026
 14:27:57 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Enlin Mu <enlin.mu@linux.dev>, "tglx@kernel.org" <tglx@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"enlin.mu@unisoc.com" <enlin.mu@unisoc.com>
CC: "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: RE: [PATCH v2] genirq: Add the entropy pool function to the PPI
 interrupt handler
Thread-Topic: [PATCH v2] genirq: Add the entropy pool function to the PPI
 interrupt handler
Thread-Index: AQKd7zkye00EiKKaedVNBJHhw407x7S/WTPQ
Date: Tue, 16 Jun 2026 14:27:56 +0000
Message-ID:
 <SN6PR02MB4157A88F6B527040FD217F8DD4E52@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260616100211.3068-1-enlin.mu@linux.dev>
In-Reply-To: <20260616100211.3068-1-enlin.mu@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CY8PR02MB9201:EE_
x-ms-office365-filtering-correlation-id: d066a33a-4ddb-472f-62ba-08decbb375e5
x-microsoft-antispam:
 BCL:0;ARA:14566002|13091999003|19101099003|19110799012|31061999003|8062599012|8060799015|37011999003|16041099003|15080799012|102099032|53005399003|40105399003|3412199025|440099028;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?ebbgg/u9qLXeQ1okL7dwDatO23iGJfmqSsivUvMVnQmlo0Sed1BKsl/KHe/U?=
 =?us-ascii?Q?T5KSedIlBbemwY3kZ/0yzXrxfPR0EQg6Qt9MzMLLve4BdyNyRWRPhr6uYde4?=
 =?us-ascii?Q?Z2Rp5Y+8idHhMIjEPLvEoShW7RO5uuRrQAnskx/3qM/Oh9ApOTFkKxR7R+OC?=
 =?us-ascii?Q?Se7nIPmbplAr8nfCWrbJzKsc/X0b8tbwoLwdahv/kyTvesyym8UdfgYF1KT8?=
 =?us-ascii?Q?1CSeiwq35i6PdDb/x2NO+qUZ0kwq+D+xbvh2RIRAZpWon5lsWATLvQHB+oL9?=
 =?us-ascii?Q?dqtbzJMaEWR3Z080sxIRjoKXF7ZsF2+Pl8hgEgkB11n62J5TLWmUzmfgBVh9?=
 =?us-ascii?Q?eiHwfsnfeIpT8gQWbvaOD3f9NokjhsIhpbs7gzbvGUfo5p4KkvO6ApZyKc/i?=
 =?us-ascii?Q?BvTOKgZJVjyulvzbjz5KkI1DF9RbDXrIz5nfJNkdrRSQsk5pHfYpSSi1il0I?=
 =?us-ascii?Q?8CcHpWW2rki53dl+8gQuMv8ToRx5/J75O0phWjsoxEQEEol6yYYl4OGnA5aF?=
 =?us-ascii?Q?OyP45ciaxtopRMsAhrkkiE9bNiFk5/qYLsPip8RYMSwhjhUKicfSPY2p1yCb?=
 =?us-ascii?Q?wjWrRX9BAqtJ7yNh3v1i8fl/49bHTufVjyalyQbrED4M9fuoteCZcAzdN7/c?=
 =?us-ascii?Q?Dky2nZaUBtX89t2Hx88PbjOZrHqKSf6cXaRJigdgZrB/0dq9KNl9pi1oqCO1?=
 =?us-ascii?Q?Upp0NiXIW8GmTnW84dPWROIfPIfZ8/+GJMGoJTp0Za6M+ccpLtg3ZgUKBOpl?=
 =?us-ascii?Q?woNg/z5A/gF0cvJZPNGcY6zF6co8BvdvtlR+o2rpx1Jibh0JGlJOTyTfGYu8?=
 =?us-ascii?Q?b7ZNb7o9oeNhYMcQL+iA1iF/xaZrdQuAWnURJvpcNRWraV7fYG0MiS4PK+kG?=
 =?us-ascii?Q?ZresL4l0fiNc14NQznUgAlb6wbaD/9HcwVJM9lAO2mDzlhkbdmYXt3fnoV1E?=
 =?us-ascii?Q?LO91xxrqiwdrGk+9aXGgHyGPif6bfg7yj77dCLsDgkJsDWv1MTeYCSfWiyQG?=
 =?us-ascii?Q?f5HJjX9EHJDMXMbDiNmxzUIgOTRQugn25hzrXr5GhXgtNbw=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?H27oBHsJRBerbMb6JvlHXDtpS2mT3k/ZSzKvVzX8F4cWurXLOFHg54lYi43D?=
 =?us-ascii?Q?R9aLoybjfW7qj1GF4FvXg2eq8OvIwsc5kIzLtS3u5+kQh4ealPjBRictcOSf?=
 =?us-ascii?Q?6NuRw7fNFGZlnsAUb+gRFMF7fxzBFw6RkB7MmiFUoH6QsWZOshDsSQTRZlQp?=
 =?us-ascii?Q?F75+O56jARpoNTJYZWv4Atae3liI9HmYL+3cZI3nMqKQNj0+n8B1kJG1IFPe?=
 =?us-ascii?Q?A1uRUdWpFlj+iRsAVYEFRbw38XbK6irc9QEJuOSzC+e6Bib1PvL/N5ycoe21?=
 =?us-ascii?Q?BlTkWo7FldUuN5DlVnC0P8sHIc6wbNNoae+BSYQgxjpQAj0PJXWcyRjCh+ng?=
 =?us-ascii?Q?6AR6urgErLa6f5CCB4E6mHA1/XO7DN9uZL3FUmV7yKMO0cEju8wMETRuyk4E?=
 =?us-ascii?Q?XkQbsodBNk3D4GdG8paAGJx+b9QHehQdG1r6CLi98G/Hw1XUG3eactqabOgP?=
 =?us-ascii?Q?vRuHBFVqfqIwa1sfXvLMtN1ZKxuD0u98v03gh4S7cJ5MFfJ5OdtB27T6W2aQ?=
 =?us-ascii?Q?4G3gSzNEc4pzsdX7GX72IV9ovBwJv9YDW/7OGJbjAnL7WN6EstfRBJmEqYrC?=
 =?us-ascii?Q?z4Vd1KxF6hqrzWHWNzcfz1PElirTYxt6uPeyLGs1nZTaX9Tz6Jx8PRIBDcPT?=
 =?us-ascii?Q?R7L0w9oHlIXmDU2rSqX4tc7NJsMhBMHQG2dDZea5Y86LC3u8zFq/cjsCFIpz?=
 =?us-ascii?Q?DUA4q5xGo2hA/sB1qKCqfM9nqgmbzYrFS6SK0XS5XKzrpHbRGFKxNKmhu9Mg?=
 =?us-ascii?Q?DGg0UMrJhu233Gdiopi0LWEtTp1JHPhfNbSRjS1GmpYU9YdpS+3Crx2qREt+?=
 =?us-ascii?Q?9T9XE7lLzbjAvBANYTL3BhVpj+BVy3CGLRDBY8AcItAzh//qMwr628OAD8sm?=
 =?us-ascii?Q?Rbw7qaug4OjKsER42ACCw4Bsqier4NvPRCP7vf1L4UapzLj5JLvL2uCbDm3N?=
 =?us-ascii?Q?T3TOsv6SlsY8OCwR6zpZcCZ374pm2y/4iOlG0r5yeFqCDW71rmNVZv/y9NqO?=
 =?us-ascii?Q?+fcsEoAzCqiXzk6c7TBwZuvT5M+yLsz/VOXS/yEJuJrtLNBY32D/dkv27GXw?=
 =?us-ascii?Q?M+wBHVI9PCpCDmVYr3vWS+rZ3WBKchP+dB916dXjlaVP9/xnUwZbpT/L4Ud+?=
 =?us-ascii?Q?4MgzHd0iBFZtaaETxgIcEQcpV9pJateb1viPWmp+gd2NIYPZG3HxYjBbj10J?=
 =?us-ascii?Q?RNdCt+XU1BLb6h64NbKo+m/Sj1NnpjjqNEBBqseDCIyOI+Azx8GqxGpAv428?=
 =?us-ascii?Q?Tnnah3PXsvkQ6qHbm+MZH1UEyUVgHzanYHnj45SJDJqQbYNWzdbRBovjCkZv?=
 =?us-ascii?Q?h1aa0GpEmxJwMdrCLAuQQm8qYejcOuzfS+KpJ2DCP3SrxnpG2Gzj/0/TJwou?=
 =?us-ascii?Q?kkPsJoc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4157.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: d066a33a-4ddb-472f-62ba-08decbb375e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2026 14:27:57.0150
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR02MB9201

From: Enlin Mu <enlin.mu@linux.dev> Sent: Tuesday, June 16, 2026 3:02 AM
>=20
> Accelerate the entropy pool initialization process.
> The function handle_irq_event_percpu adds entropy pool
> initialization, but this logic is missing in the PPI interrupt handler.
> I think this was simply an accidental omission.

This change has already been made via a patch I submitted. The
change is in the 7.1 release. See commit fd7400cfcbaa and a
follow-on fix in commit 512718bbc51b.

Michael

>=20
> Signed-off-by: Enlin Mu <enlin.mu@linux.dev>
> ---
> v2:updated the commit message
> ---
>  kernel/irq/chip.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
> index de754db414d1..cbbd7e7d1156 100644
> --- a/kernel/irq/chip.c
> +++ b/kernel/irq/chip.c
> @@ -926,6 +926,7 @@ void handle_percpu_devid_irq(struct irq_desc *desc)
>  		trace_irq_handler_entry(irq, action);
>  		res =3D action->handler(irq, raw_cpu_ptr(action->percpu_dev_id));
>  		trace_irq_handler_exit(irq, action, res);
> +		add_interrupt_randomness(irq);
>  	} else {
>  		bool enabled =3D cpumask_test_cpu(cpu, desc->percpu_enabled);
>=20
> --
> 2.39.5
>=20

