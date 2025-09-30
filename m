Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazolkn19010006.outbound.protection.outlook.com [52.103.33.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279932E9EBC;
	Tue, 30 Sep 2025 08:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.33.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759219712; cv=fail; b=mp+2s9pRr/6qGcDYgXNYcLd2+kUQILC15Id5UeMs185kr8HEp0b0ntvwL8N8RBc51FCiVdDWzR9tWzW0PX0DGuU9SDbcbIRqrmcL5AtDN2HhKZX1Xi0GqDbWk/UCOngUL2iVa43Zt9YOYRZncivXjabVXChamHnx/gh20qe2P6w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759219712; c=relaxed/simple;
	bh=pUG1BdzbKm2TRcLIyvMNis3wPIntjyzTqNfM+x4p9CA=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=jcHLI8ZJnvYfZCLl4LdnTNFqtD2FurMRWEqX8E+ar4w9qoIJx7rx2408/ozyN9OZ87vuFKFbTLUkvGILDW6qgN0p5/vT+Pqn9hhKVxmoOvJeIpCl0QzzrTp4YwaG2bFyrqxd5p9PAAScRVwm/I1AdGYayScGE7D5UpRUaA+9i4k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=kV5twN1r; arc=fail smtp.client-ip=52.103.33.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="kV5twN1r"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GqC5eUfrKiOgN2nV62kjHmcOocqR1qF7gFg7lNi1+7L5YqKk0UuRIigZQnXOlwp06T4zPtjIqCnuzdEBxqREfnIwBd+pQLzLx8PtKusO69AfXcjKNsjIWCDOyf0xW5ot8+uTzmqnSjV8ljuq1HNrim86imyUU3CNdiWddOamgE9abOJy5GA5a+Iu1D7YDBRzyXq+9eZ6tsbg52S07nPlmMch7yTeol2enzZEIpQzl0Z43xiNp6DdQXZ+vmYbp+3kiki/S7ibEhN52EYesDFmze/RX1EaSKRNH6w3qOCeY3NBSsfQMpii2j2KXNqrMTAb2xaqAJjv1c2RhOPj5Ug2Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x7zGZEX76sDyqFJ6AV69hdryUu2Rrpr0LdjFzKZ1zd0=;
 b=TvkVjlvXJgGGoAqB+8uRm2Gm58Dj+1V9oKExtkNU32xv6k5/vfE3ttu39M0wR6Q6oW7BvPVARI4cf2snnja4XlMoBjIGbFmDC4Fj7QcKgkWOnL8T2LtCdL0w6AnV9Rr+DJ4wd1qgbVHNoHF9Crb9WxeRe3ZOPTaYbhy4fC95x29u9crTggQ2nA4YfmlOD6OaoRdb2RCBSlC+vjmPMn12ID8CqUCuPpTCElajNmzr+6jtoA+sRGnL7wbR4Bn+QSfnDJabV6lErFvx2O2epawnvbKaUJjRc6FqPUupQOkOvwerwkY4OPUhwmlFj3azdW81Mb1/lsHFq8p8hiY20/QACA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x7zGZEX76sDyqFJ6AV69hdryUu2Rrpr0LdjFzKZ1zd0=;
 b=kV5twN1r/zftGyVt6TBooqAGxAk7p/l8Ejl8lN8AlP1+08wPsgPKwQi62Hbu///Wdsv7syv3Wkgev38xycOojGPPFYbS3H724K8WEkol8m9ZfJwKZKmDJJLaBpq7CE541oz/j8AQZ9v31hY5EI1xRQXv/hz1Oy38UXchQmkIGdgtWW2TibY20+WrKtL1PKILWBwQ2+DgDj4DNSZcnKAwScK7tMQD5QU45AoISY9YL9MDahMN7sx2I0RFPbqDHyFlb6uOhMRdk3sSM703Lw6FajLWVBWpVf5XkxXbnMpbVEPNgpSoMxtlgtQJJUo8nJRGLft8DFd7MmAZvAhqQTMsMQ==
Received: from VI1PR02MB3952.eurprd02.prod.outlook.com (2603:10a6:803:85::14)
 by PAVPR02MB9698.eurprd02.prod.outlook.com (2603:10a6:102:318::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.16; Tue, 30 Sep
 2025 08:08:27 +0000
Received: from VI1PR02MB3952.eurprd02.prod.outlook.com
 ([fe80::60e5:4de0:ff18:2fb1]) by VI1PR02MB3952.eurprd02.prod.outlook.com
 ([fe80::60e5:4de0:ff18:2fb1%3]) with mapi id 15.20.9160.013; Tue, 30 Sep 2025
 08:08:27 +0000
From: David Binderman <dcb314@hotmail.com>
To: "kees@kernel.org" <kees@kernel.org>, "linux-hardening@vger.kernel.org"
	<linux-hardening@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Linux-6.17 meets gcc trunk
Thread-Topic: Linux-6.17 meets gcc trunk
Thread-Index: AQHcMeDQUMI/f5rYxUSYVp6C1CeEpA==
Date: Tue, 30 Sep 2025 08:08:27 +0000
Message-ID:
 <VI1PR02MB395284606387C101413494EB9C1AA@VI1PR02MB3952.eurprd02.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI1PR02MB3952:EE_|PAVPR02MB9698:EE_
x-ms-office365-filtering-correlation-id: 98e8078b-7dfe-41a7-171c-08ddfff8890c
x-ms-exchange-slblob-mailprops:
 qdrM8TqeFBtg1x3yx1r6QKZAk6LGeuzaRN2UyMG3k9MW6JEs4VVWRMXZyDwZ9ID6HOgHmsPtabael4JQf+ySY+U19ldipupJdU13MDrwbgc2IarKaYOs9QnWSJ4gLvTHw/mGXFWvLw5g7pGcMeBUvEMsHKMrHBrMHVuVLPqEIfT+HqduC6MEfkhXab3+r/8FJPFwCgK1BIIK//P6zKvcBe7uQwlCSIG/Ztij4ICV5/0ocNRsd2RmEtX27uvOGOP+cNe8dGrus752SkxkbnAWwVApzJOv+b+VIWugdR7fko91Lks+utG6ZI+NLI0AQLCQAl8SXA37ToskNjnATvPSanDSvRYO79QokjExwTTAr8NXHuCVkjHZoNlTW54FaHvnfQ45vvkrUqcqx8WAwKsv7eSD3W0IFOw7x5+6bRKplB8mjpdjJJ+KBY41X7Wi51UotTq/huz8Oxa0nk9L/316DkYxorKNhOM6A9u8hnwTTxWkTKYbw9j6c8AvKZb7afxZ5xnq7imUzL1SxHgckmCnh4+JtbyGky9RKkh5YpW6z+2vn+3vhgCOFAVZzEhNgemGQWcjw8sV94qr9JivN9KnFvhR+7bp6at7C3sES+G3OCccIwKROQ/rAqwz08ZHjYg9GLChF1xAggnaxbVRU/nPRbWi+N/22PqIZVe0ffDxqjC8XXQdpO92xktoyf2GHOhyrpOCZsAmnBZ7arLTAL3nQPQtlkHw8gI3DsNVwFNjy5LdB+D3Y6dccaCNGiuvjgdBe8BqsSSltzf6snBaPhrzGqyMl5mZtJKN
x-microsoft-antispam:
 BCL:0;ARA:14566002|19110799012|8060799015|8062599012|31061999003|461199028|15030799006|15080799012|51005399003|40105399003|39105399003|440099028|3412199025|102099032|10035399007;
x-microsoft-antispam-message-info:
 =?Windows-1252?Q?D4dl/z/nPrQomus03W/SXLaE7dLinXRgFBxXOM0s2V8hbYQM6vN5vxLX?=
 =?Windows-1252?Q?wb4/wzmufAX9R5QQLKfHxJMD5N56wMlJwElU3aSA+ruGPIEFXaksHmAD?=
 =?Windows-1252?Q?fypmPfv/LbQb4oKXM2aThPukaPubE+j2lOiT/q7TT2ovTTpjOBPNW7cF?=
 =?Windows-1252?Q?ggpJGTHYeHBms4u23Emq7CnczAz8c5uMUSDRz+akyJY27PMz/7B2kKvE?=
 =?Windows-1252?Q?X8TnDA47nqGLetENVGd4F0PKBx4YXfte+yGYSASji/riiU5J0A3DfYkx?=
 =?Windows-1252?Q?u9zALWM7g530xs4nHfmgihw6I0aioyOh46dbM+Ll7AV0M6UQoRqM3wo0?=
 =?Windows-1252?Q?hdiV1ZbPmot1CxkJ6vwrWVAKdoklp3/CMEv3Iq2mDycf2DuHZXwJgjZd?=
 =?Windows-1252?Q?vNRd7OSkonNk1xN5KczYb6LDGFK0cba62gmuh8RR3rc3HLA2KCC1OTR7?=
 =?Windows-1252?Q?mEqxKHyx/Jmx15CwLDAkB1Ec5lCugTxqY14xi1PEtn3ib2kV8VjOhoeQ?=
 =?Windows-1252?Q?P+Rh8PZ3KqYd8QytZGGSZa4e7TOLT12cWqHNDxtBnT28yFxfhkt2ppxB?=
 =?Windows-1252?Q?3k2mMSGBtlO5ErkN7N+QP2UsdElSdXIdgYOvLK4NsG6p5IuxhZRBaiPC?=
 =?Windows-1252?Q?6hibUIfWyonc118ea7ydHNrlNyfiZDyJVZXE5+OR9AHf50LrEj6uT8mH?=
 =?Windows-1252?Q?4ijDsvew0mnV88ZadozzmfDr/n7S7SOaE8+viORhNFq8/v9sOQklQHzZ?=
 =?Windows-1252?Q?WKJyLW30wbWAJVgp5AfSmKHCA5x6+jSdzFenWz+tWCoSNF6evosMVVXX?=
 =?Windows-1252?Q?KivY6EvaZQC3ZjdYGtgCNUA00T85CxI/aOkDNJzXil9OpJh5eE4O4rfb?=
 =?Windows-1252?Q?x03oe9glIamyVBf7/PapBnZMn/7jxRPMqIA/Kr57rOr+2b2ZVf52WzZ4?=
 =?Windows-1252?Q?YUb5BEPtGp/8WEkMpPM+jfs+PkNVexYDpMgbReWN99XH8x2s0dhrk/x4?=
 =?Windows-1252?Q?IxWvT79Ho92Ql4HvEqMZtTZfzdAVzpz+bTnIegbBo024LbsXiMH5Y92E?=
 =?Windows-1252?Q?om0hyQb889NG7AGrDts7H2QXX5qKUeeCnZqw2PFpD760Qy7U3p9nc3sf?=
 =?Windows-1252?Q?b4CWx+nUPIlNNqnM8TIayIU0UQJR7NjM9/boKzCdYMFSqQJmIAEXnr3+?=
 =?Windows-1252?Q?fvRf4NZ1VzXbLSmR4pc5rqrviGpXnh9ye+ve9Tle+4RwqqHOIDPHLekM?=
 =?Windows-1252?Q?uNgT8Qv941yC5+dkuwLS8zxgtZszCg6S+l/8q8KMjelq6ZQVIvrJOI6J?=
 =?Windows-1252?Q?mIiQc3Sp6YzvQE9SL7hgQMcfnyl/UkJ3cxL56cUxqhGYwjsSXQdOKvfC?=
 =?Windows-1252?Q?yE42blNE4+QBQg=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?Windows-1252?Q?wRJx0MGehwOBIbleyLct4Ooso97iOWb70lO7EygBFT9M+nwXLzUVq7fe?=
 =?Windows-1252?Q?bXeCX54lnMsPgVNIKcR2H4Wu4Akg38/t9JARCNrxBtJYG+4XFvL9+hAH?=
 =?Windows-1252?Q?ooi0hrkVyFqu9KYdU2RtfRR8xTMfNfmzIJCntaG8ggDpzIx9tTmzy0H6?=
 =?Windows-1252?Q?KgkurFzawzdoV7WSN/0r0FTjMeFhjzNAkHnmfNIMKCpQhCLkp1IKxIQa?=
 =?Windows-1252?Q?uM8t3DSiRxRZr/tUU9tHRZyzYTSwbCZYC7qsA1p0c8Lg1C2SOI8Be5uq?=
 =?Windows-1252?Q?eNqPhoAyyThb86DvevdVp1LeGfo0lV455gkapHVytoTSx5t3J30IMVR0?=
 =?Windows-1252?Q?YyZa0gTs0OTYMpwqID7RUTu5ONmRaLuyy3WMgUlFCDMYvu90Z+OwLxlN?=
 =?Windows-1252?Q?XKGjWdFt3Px/WgkyDHmeKb4R0mKeJnHTEWDmh4EIxHzImALjRQZQoaCa?=
 =?Windows-1252?Q?Kn1uraxjdgjNyhp7ed4xO1dGxdJBKXZ4bfA/PgkO2gj9YcWw5phEsVEs?=
 =?Windows-1252?Q?j/iH9eYhUFF5izTlNqlHv2UqOWZrOvukxCUBz1sQLUMQXHp17S9IBQPm?=
 =?Windows-1252?Q?a8NsLSpFOURZchrJvKIN+yNfJ/yRjQ6iOXJXKOp8cZMmDHDJJMclngrk?=
 =?Windows-1252?Q?xvBKFAQuQvuLyo9o5uKhZ1lD8rd4jiFcSy9wHTj1SULFtX8pWDROTSJo?=
 =?Windows-1252?Q?IXRe/8OTDdILPnFez7enXv5fcutRQ3tEOr+zSf9FPUz4nxPxIp5rKbih?=
 =?Windows-1252?Q?6FNs7ft9u1kefGX7fn/PccWNUQxEMNZ6PPrji7yzU1wD9KV1BRG5ZD9g?=
 =?Windows-1252?Q?DtvM0BhqtBqcoGDscPEEYWIclrmlnVtt8G1QQqizg3oIHBKslF2dpaXC?=
 =?Windows-1252?Q?regdN2D4FneOzH8NSdUUBPAUghXBG26ewJl1WwATUxNZr/Se1p8oJPJd?=
 =?Windows-1252?Q?jiKXrfh9V2bveMvzXmGAcmqsft/5GzpiOLJig4bswelblA3TikGioJkf?=
 =?Windows-1252?Q?Mf910OmeoWd1WSNBUqF1nSY8KuDJ7T86OGAigA2vE1wc/YbTEmjCGaAz?=
 =?Windows-1252?Q?IZ94kt9Qj/i6LnVOGBiTbUsk3gxCA4VGb10oIGP6FrBT2o2Za/vi+m7d?=
 =?Windows-1252?Q?If444yN3cnRT3/BHxQlyVo1RoDmt22yfzdQfwFpC32aKfVCRjOcoDAct?=
 =?Windows-1252?Q?x2O/Bj8Usui7j3E8mUtMpsnIzp8lqWEQxrtr0987BOMJyQ0nmnEhypR+?=
 =?Windows-1252?Q?TTfVx5pGbUVrHAfr8UQVmsMPVnffJQ9BgxySXuuc/ObuaC4vuekqwYLs?=
 =?Windows-1252?Q?4LFJeQ=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-8534-20-msonline-outlook-5faa0.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR02MB3952.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 98e8078b-7dfe-41a7-171c-08ddfff8890c
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2025 08:08:27.2709
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR02MB9698

Hello there,=0A=
=0A=
I just tried to compile linux-6.17 with gcc trunk. It said:=0A=
=0A=
  HDRINST usr/include/asm/types.h=0A=
In file included from scripts/gcc-plugins/latent_entropy_plugin.c:78:=0A=
scripts/gcc-plugins/gcc-common.h:176:25: error: =91TODO_verify_il=92 was no=
t declared in this scope; did you mean =91TODO_verify_flow=92?=0A=
  176 | #define TODO_verify_ssa TODO_verify_il=0A=
      |                         ^~~~~~~~~~~~~~=0A=
scripts/gcc-plugins/latent_entropy_plugin.c:567:27: note: in expansion of m=
acro =91TODO_verify_ssa=92=0A=
  567 | #define TODO_FLAGS_FINISH TODO_verify_ssa | TODO_verify_stmts | TOD=
O_dump_func \=0A=
      |                           ^~~~~~~~~~~~~~~=0A=
scripts/gcc-plugins/gcc-generate-gimple-pass.h:86:43: note: in expansion of=
 macro =91TODO_FLAGS_FINISH=92=0A=
   86 |                 .todo_flags_finish      =3D TODO_FLAGS_FINISH,=0A=
=0A=
=0A=
gcc trunk is at https://gcc.gnu.org/git.html. This error has been occurring=
=0A=
for a few weeks now, so I don't think it is transitory.=0A=
=0A=
The kernel configure script is:=0A=
=0A=
$ make distclean allyesconfig=0A=
=0A=
Regards=0A=
=0A=
David Binderman=0A=
