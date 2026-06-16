Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010034.outbound.protection.outlook.com [52.101.61.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF65D199FAC;
	Tue, 16 Jun 2026 03:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781581469; cv=fail; b=GJHbh0WiiG29jUC5CRJt4SorFG7waiQsoK7SVh2x0TlQK1eSUbFWs+D62pcfMYmBAivKVZaxy3BvwOYU242M0qu9+v/rvWgYwLwXDi8xsavY2H6R63+8W4VMM9NnPM6bOrjKvfQRAyXmO7IceyQzo0oLCje7VACAxQRoNNA7uMY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781581469; c=relaxed/simple;
	bh=7SCOcROPC47x27c321P/jzELbQE82+1GLqXpixFDi6c=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=fdATaf/3/8Gi24YiRYLVHl6T7IfxPvfhX/tsWyzg1agBPm2kFil4MAxlRmgAELXHbSqLnJ5y3RJ/nYCZmk26c3j8X0VHrwAJN5s3gnf17ONl2KCcO9LQadxGgw7jhN20iqFPkhCXEg6pZroRclNWqEc+A1BaTq38uYoUB+/Bueo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=T+v3jqOW; arc=fail smtp.client-ip=52.101.61.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="T+v3jqOW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dmw0ru8Dwd/Pf+s88V4d2JtSFg0f2W3P2oQzj92SE3NHiDeN7EWvGFug78HIFto09U8NtzMjlqRwRF1tAuojzfq0bRjwLlAcoGRayP2pJqvlc4m3warPQixRAWAmOvrzUn2YcrnEBYo5HzmK0ffE6cRcLj9KjjjfpbebPI+8mefpo3SEIv7AfgnOdPnocweUgwkd2qJ4/CG9T8KKP4GiNecE3YitD5L7Z/fITd7zahx+h9sUMBvOOLGT+y99GxntpuvX3AfSZaI2Goh9iB0MQCH8nXFJTuJsltr17Oh0+61lZVgR/qyUH2fU4U8x7PbvwZmkAH40x1pQbFHEu/qeAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3qFjOW59QsRdd4uKat6dlqTNSb0rc35YXM0B/s1vU0c=;
 b=kIlr/4wYvcUWctsXLZY8t62qVWZOX9Cr4Gc38wRNfII/yw29SBAxBmBH5JliHMYsb2Y3C7GfxDTtvHqWl6oGE6VnOIbnHEYhBLpzSfxl5jeMnw4zoX8S0KFGkgCYBSWkdlp3xHRiK13ewR3yPM8MVjRl7p3iNfGulNe7/ZRV2IVrbSlDrAll8Ipvov4bYW7PVsIhVLL8sX56MNctcBpD+cVt+jNGWd57qWjo7COKdFbSwceSa4SgD/Mo6flR4ueMlQj2GIcXqtoTguaBzeLy1OeyvGxMOnjer2HQUh/GkDD37yrbAhggptKkoVftWrsmiymxNyfEdTvWZcibC1N3nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3qFjOW59QsRdd4uKat6dlqTNSb0rc35YXM0B/s1vU0c=;
 b=T+v3jqOWs3dZoBBRXbKBA7XsWZeRMWy7tRpcJBPE8Qtnl6AIJX4OI0qVY+7IPC9ZeWUOphVfU3BwUYOJ/yv6uYovm13yAdbp4FvM4RAcocpz8wUGEbit847UGINiu16s2miT+YsfZYtsbifjK0G+W/El7zdp+M6RuMNw2sMWhVZ4HPTHwWIFQPdvJniFPrDFx0xxBbF/YluxV0Luk2gD2Z6WLh516B1qBvKyYDZi1Ttt/T8le0jrvG+Q4jupZc5gMe64EirjD8wQnyG7RjfRPwUN7ZvAY+zoVgcHDJJrw1fqRXMCwS3gB+PzTSvnLzXSWaEztB3sk6RKAfhS/KfPAg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ0PR12MB6733.namprd12.prod.outlook.com (2603:10b6:a03:477::9)
 by DS0PR12MB6535.namprd12.prod.outlook.com (2603:10b6:8:c0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 03:44:23 +0000
Received: from SJ0PR12MB6733.namprd12.prod.outlook.com
 ([fe80::f00d:2f6b:6f9b:8f97]) by SJ0PR12MB6733.namprd12.prod.outlook.com
 ([fe80::f00d:2f6b:6f9b:8f97%6]) with mapi id 15.21.0113.015; Tue, 16 Jun 2026
 03:44:23 +0000
From: Kai-Heng Feng <kaihengf@nvidia.com>
To: rafael@kernel.org,
	shuah@kernel.org,
	kees@kernel.org
Cc: julianbraha@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	csoto@nvidia.com,
	mochs@nvidia.com,
	Kai-Heng Feng <kaihengf@nvidia.com>
Subject: [PATCH v2 0/4] ACPI: APEI: GHES: Add NVIDIA Vera CPER decoder and tests
Date: Tue, 16 Jun 2026 11:44:06 +0800
Message-ID: <20260616034410.70675-1-kaihengf@nvidia.com>
X-Mailer: git-send-email 2.50.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0024.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::13) To SJ0PR12MB6733.namprd12.prod.outlook.com
 (2603:10b6:a03:477::9)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB6733:EE_|DS0PR12MB6535:EE_
X-MS-Office365-Filtering-Correlation-Id: fe2bedd5-8e26-4eaa-a2d5-08decb598e00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|18002099003|6133799003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	XEojVsDMjryw9K5kKQjT4zYh7zldNwtzi7ZEF6cQKeQtNGlo1MAalVUadRpv4nQIOE8L18FiuKzVtUy/D6vE9zI1WSkaw4leYx43I7RSM1Mm0TQlXuBX2tj9hdso8oeN2XRvZ8QcU7HBRaUBDm64oJuhjH5hG3ym1yRTmb9G7FqdYdMyuAwEHASo3k22kb2RweY7LMvzyR2YDhr4NxWqO/W0w5GYPw/xZM4NWx7bvwcYf1chxF10rXf2AHoG1fKNYi6HMUm7hhdMnX1XDO1D9PT0v//nM1Gschy1ZHFJGEUmP7n8kkyC0KKsd5iSxa/Eq+ZPLLdY39fk/fYd7Gyo+IE+Eum2hzxqx0xIF0zC17VIT2kFtP5GMfn/5BKw/iA+l6FonVmPMI0/HoNY0QWuoVoVpVakTowbJKWLvqHvOYyTXfElA7qwFegWgqYp0qzvuPhy14xbptlfhVsOyUEhCjZprHTW5GvsQQyEwCVFDyK+EI+j/Q9qq03eKBs0Yv2yKuTyS+G/BHyanro7OJG+CBzPGgfGbkis4+amPn0+y6xHvdVwt67VKLlQClPdlOHIMcbY5c4T0mnFqpwrpaEfEjTuHp6ziZdAJ5mMCwHT0bMDFjaBwVc2GRT8Pb1+l77g42vKhP6hRvK1DQKv7SHfNi5DrKSstljGA3OeSsB60n7JNzS0cQGLz+Wnt5ydJoYc
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR12MB6733.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(18002099003)(6133799003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qubjsoLTIqEECgKniLVrlNuzYX1R26qh5ei5SN6SBltAQidpnJYQWQDeFBKz?=
 =?us-ascii?Q?TZWQPjfc/m5NNxsZe//BNswCqr66L3wBVOaER5bgLUL5H/iu3BnG9lj4bxk+?=
 =?us-ascii?Q?4tXCINzZM1HPN21yJmXaK4eo9arQzgkkbuT47Q9lGMXbhzSHKlsqBIyNYDup?=
 =?us-ascii?Q?xi3qRXWCMEXIwTXeTQDvUdbtf7yZqyEGuEEhGyfejBVEH9ijWimHW/sirzvk?=
 =?us-ascii?Q?EA0pIfwHS/+ELVRA/GZhnr9kEfHIS/CEcOwvT2jpJCfRV9tkM7Cn0LIGjI9t?=
 =?us-ascii?Q?pjfKRovgBsykBYLWt/bGMfE5lVpOrVrzcZjkmQ3Mv2bxNQSi260qHJ60bojA?=
 =?us-ascii?Q?fNKHmVy5Gd7ryIXJwDmt7Smf/AFuiehVALZOuK/MAs0vPg7dL4w6tUlGTfbk?=
 =?us-ascii?Q?QGhurxqQKiL8NYxbW4RTEmBST4hGtrVfRyKpmx3C7Uy2G1gz9HZmOH6sw+N1?=
 =?us-ascii?Q?MqezLVyf0vRJ+p0CkSe9s1dFcN0NWIIaiTCMNwi4FD94pU6LGLkeyn3zXpww?=
 =?us-ascii?Q?QwDlqx9QsvEJUwcHvaZUPrKCbSoWqCl1+lVQ/dgReGAKk/xS0E4e8G9xuxYa?=
 =?us-ascii?Q?O0aL98Nu86QJ7YjJtkLKSFzQRSXHQHmWwPOqwlq6c3h/xHjwaBip2kn+CprY?=
 =?us-ascii?Q?D1Ggwk2OaYML1MEojeMWkua+zL48vR093aTk9U4sjy4621WxwbCbFsxdlyU9?=
 =?us-ascii?Q?Dyiy452/MOPc8EYnhm4YdxHPTnac13T5KDK+sVIblFPfBEM0o5aqr8mma3Y6?=
 =?us-ascii?Q?OxfRYqYYM1ZeI2UKAPFOuPVXJTJld43eUnJNASFef6dHnvSdrVFxzYm2gkXz?=
 =?us-ascii?Q?q65Nu56r/ItKtBNmXxVheHQdI4SsPF2K+MnA74NuF44EletxexW8pt3mb3WK?=
 =?us-ascii?Q?m5holFmweX6+bgRTsG4Rdx1zX9QmMVMqLmYtOu74be5w9OVWnk4aP0gJl9Pd?=
 =?us-ascii?Q?xdlgwUXXckie4cc4loZcrYk8QiPeumxDo8Bieyj6/gpUVZE//xHNMyeQjFmr?=
 =?us-ascii?Q?UgUxQZSakni5BGzg0z91CpnkNodPyIjxBEVEqXYXyo13cOEbClsD+UTNJUGU?=
 =?us-ascii?Q?j7Y6ioDV/vosqYi06VDAw040QvNYgv93+Dm4I+KKdLWweAyfUy7GCqe7EgdI?=
 =?us-ascii?Q?z7+eGlsTd1GryYy9Gu+qmCGpzZeqLGsJSqP4cn3U12ES7AZDhXszBuwlXkMz?=
 =?us-ascii?Q?eS3klCeCvKE620f/HgvFrKAqUMPFqBH9Ez5nsBL2iE7k641Xxmn2Jr27jhDa?=
 =?us-ascii?Q?dXfOD5PePUc17olP2gxw3kuCjnhxgHK/qDoixF+I87YmQH110hroJL+Vo+mr?=
 =?us-ascii?Q?DSIoiFEdgUCQUqicNcJSmDMEANq3ESjJHaGtX2LOCt9k0/WbSPYxcZzNmebc?=
 =?us-ascii?Q?DqMe4UK+ilnzbZFao1VqiqEt1veRw0uc0zbjZTK8x4c/f1nLNPJOTUTmi9Zf?=
 =?us-ascii?Q?D2srTgl3zd698EZi5ujxXUZCGciB0Zylxqrv80vaHf5JUNaHy5ZVxeS86O2z?=
 =?us-ascii?Q?iu5lf2WziLMNuZqyOhy1qkfmV7q2WYwJM0tCnlZlt1/EcfAA1h8AD728FTfV?=
 =?us-ascii?Q?jf+OZIQmroKPUaohIxqJZhFkM2Sa+BFMn3hI52VdTMtHwpWpTnTPaYWp1zuE?=
 =?us-ascii?Q?3u7MeVcjygG7pjyE7agMZitEp6kSuct3HIYqiew/rPtRSRxSK6d/V9f9mYSs?=
 =?us-ascii?Q?ByLefCUYYc753t6h/rZ73U12Sd5xOkgtQK2d4zkXXgMx/bpA/9FSllNE4JTH?=
 =?us-ascii?Q?D/6MyK5luw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe2bedd5-8e26-4eaa-a2d5-08decb598e00
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB6733.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 03:44:23.0899
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OgXN1YYuQzs3g7eQJGIX9OowLw4j0wN0rwY2dnvQBpC+aTcD4K7Ed4x5xiXBJX7YpxXc932y7cFMM+BDYmxqhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6535

Vera is NVIDIA's next-generation server SoC. It reports hardware
errors via ACPI GHES using a CPER section format distinct from the
existing Grace section. Without this series, firmware-reported errors
on Vera platforms are received but not decoded.

Patch 1 refactors the Grace decoder to separate parsing from logging,
preparing it for testability and for sharing types with the new Vera
decoder.

Patches 2-4 add the Vera decoder, KUnit coverage for both decoders,
and an EINJ-based kselftest for end-to-end validation on real hardware.

Kai-Heng Feng (4):
  ACPI: APEI: GHES: Refactor Grace decoder helpers
  ACPI: APEI: GHES: Add NVIDIA Vera decoder
  ACPI: APEI: GHES: Add Grace and Vera KUnit coverage
  selftests: firmware: Add NVIDIA GHES EINJ selftest

 drivers/acpi/apei/Kconfig                     |  17 +-
 drivers/acpi/apei/Makefile                    |   1 +
 drivers/acpi/apei/ghes-nvidia-test-fixtures.h | 233 ++++++
 drivers/acpi/apei/ghes-nvidia-test.c          | 704 ++++++++++++++++++
 drivers/acpi/apei/ghes-nvidia.c               | 480 ++++++++++--
 drivers/acpi/apei/ghes-nvidia.h               |  63 ++
 tools/testing/selftests/firmware/Makefile     |   4 +-
 tools/testing/selftests/firmware/config       |   5 +
 tools/testing/selftests/firmware/einj_lib.sh  | 189 +++++
 .../selftests/firmware/ghes_nvidia_einj.sh    | 144 ++++
 .../firmware/ghes_nvidia_einj_profiles.sh     |  46 ++
 11 files changed, 1838 insertions(+), 48 deletions(-)
 create mode 100644 drivers/acpi/apei/ghes-nvidia-test-fixtures.h
 create mode 100644 drivers/acpi/apei/ghes-nvidia-test.c
 create mode 100644 drivers/acpi/apei/ghes-nvidia.h
 create mode 100644 tools/testing/selftests/firmware/einj_lib.sh
 create mode 100755 tools/testing/selftests/firmware/ghes_nvidia_einj.sh
 create mode 100755 tools/testing/selftests/firmware/ghes_nvidia_einj_profiles.sh

-- 
2.50.1 (Apple Git-155)

