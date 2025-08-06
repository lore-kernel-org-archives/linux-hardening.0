Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013068.outbound.protection.outlook.com [40.107.44.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E3A26A1C9;
	Wed,  6 Aug 2025 12:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754484251; cv=fail; b=ro3yNkHFhjUwlcWw/nvm+HwPd1dJIhulTnG2oB9FsCenDT46LnxXI5VwXKfoVMfLQHtF33CSpZJuCY/5EMJ7W9pEY6cAgAG5hI9BeDzgADDltJVfOY+L4syRCiEg7g2fGmd94Z9GVdBIL0ggbmoCDe+o0WX8O+c5J66E6dm83XY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754484251; c=relaxed/simple;
	bh=xZ/7Chbl1h5ncO+YasGfkXjy9qkmEp4s0fIMCqFCZoI=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=rUvlA0czKY6BmcOj9ynJXaY1sf3Bn+LbZ9eu3Jsaw1LKkLa1F0sJ0CAIA+aAB00HhmVuBkvZVl+H1kKRDdveKK3rWn7AAFWMwTTGVBXE66r2FVyDHBVhC/d+yeNsOGsiRVzWPPx6qw6drhMnVVl5DhhNY3pqIHI6uucIQMMxONI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=I3BjXay6; arc=fail smtp.client-ip=40.107.44.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="I3BjXay6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vXgEnaxMECnqVKFY6b63KcgwP5TUZrUHvj2NYatBUtwIqyHb8EIN2S5FF5iWEnQWoE2cbHMW9CQ10dy1qDzGPP28ShTzocsL9tNSaTwHz+bevF5jeW0Avt0sPdKhnVj2DhufVqh9amd3p8NQZ6AQnTOFkOo3xCekDNeujPC/Cfqf9pKmMFfH7hE7BLYEFLwkFycWvNYWAC+iEa+Y9/Fyed0EmmKeelrs2ooxxVAimTkDGFf/u6EKh4W42MyS+F43nex0f1p7wUJ0+EMN/Q0O7L3hWhSl2jvzl8nmsxwLxfDPgV0XXMPJ9vgisB7Y8VlUJmlBnrciZGJ6BNP5fnnQcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cXRCL5tqL05/HVFBnnmioRw2NPDO1SgrZuD1rbZm4vw=;
 b=o38W6BRk7cXDrEV2gEAjsI2oess4CnEznehz7OdV8w8uVpUFguM8QZbHjre13wH4zBo0fU7G0zEuyn+2ncFvhf3uH3UDDXbU4hlUe5ju6vtwBdhZed7PXqs6nfqRHl1W7JZB66TQynVNzqjW4ZfHiE+iYj/mdRVLlFPwDsQOGIrOR9xI/E96fZTpG6jXVhOSsvaN/OH7Me+ypIRUZapUkf5jif21zsT4yJrrV3463hoviIYQNXILNYlTmiDrZtU218ktGcyUT36RN201kbH8WG3LbBPOWKyFejkmNgrxbLyFx/X6Aq4EKGoQP2sLaFzJ/GiQ76sMQ6RPqYaAJSafEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cXRCL5tqL05/HVFBnnmioRw2NPDO1SgrZuD1rbZm4vw=;
 b=I3BjXay65jdwG48/OU5Z5J3AhJG7M180rNDXyqtoRYyszHKUjZjufUli4kKibHuyY0uUg87N9ehS2p9GJLNMlTV5YQw3nRkGvRHQC9/p+cHlPDJ1CaZhHj94Rn92AOdTIgEC0dqvEAifSCXpWblbgA+931ACCrUMNasgbySGEpmR4Ps5HIb0MprybJoqtaTThSUohFmRjucypGmG++ph/+KCFpAyK3Yip3wcgAoAP/L+dGz8WMykaU9O8vkD6MKDnkx+BQaD4G/MKjobamPEMOjdbVYBJFtVVHIInNP3AlrH2w1H8fNdJLCoCFrnrzSJ9aZ+hVR45IeiQKu0svtgdQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TY0PR06MB5579.apcprd06.prod.outlook.com (2603:1096:400:32f::14)
 by TY0PR06MB5305.apcprd06.prod.outlook.com (2603:1096:400:210::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.14; Wed, 6 Aug
 2025 12:44:07 +0000
Received: from TY0PR06MB5579.apcprd06.prod.outlook.com
 ([fe80::4f2:e048:7c93:f263]) by TY0PR06MB5579.apcprd06.prod.outlook.com
 ([fe80::4f2:e048:7c93:f263%5]) with mapi id 15.20.9009.013; Wed, 6 Aug 2025
 12:44:06 +0000
From: Liao Yuanhong <liaoyuanhong@vivo.com>
To: Kees Cook <kees@kernel.org>,
	linux-hardening@vger.kernel.org (open list:GCC PLUGINS),
	linux-kernel@vger.kernel.org (open list)
Cc: liaoyuanhong@vivo.com
Subject: [PATCH] gcc-plugins: Use swap() to simplify code
Date: Wed,  6 Aug 2025 20:43:41 +0800
Message-Id: <20250806124341.382446-1-liaoyuanhong@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0056.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::7) To TY0PR06MB5579.apcprd06.prod.outlook.com
 (2603:1096:400:32f::14)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY0PR06MB5579:EE_|TY0PR06MB5305:EE_
X-MS-Office365-Filtering-Correlation-Id: 12bbd6c3-bfbe-4898-c6fa-08ddd4e6ee37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0B+9n0phz4lJPACpD6fb3YTdt35sWZhUf82WQSRiF+StO5ckdvwsMnKDjlIe?=
 =?us-ascii?Q?y57PSYA/STlDVQkVDCpNEmSg5gMPo06zowTuRRfvo2ikR8JmNvZj8E3YNpdI?=
 =?us-ascii?Q?rXvA9PSztCPper/ceCQV6TMrnX7pWXRd9UsrHtB0D3lZwsH5FD7BkwN/lfyT?=
 =?us-ascii?Q?qVubXfm6/SSR5di+/zS/h5bYFH6MHSurLsKT/QwzXblT8CcyIyvPfcPa7QSy?=
 =?us-ascii?Q?ICRVkMOsrbOmwwU7W0WB7Fm81RR41bM2tt6mL03jbwGFDtVUXqS1SdLIgzz7?=
 =?us-ascii?Q?3iAcZqV26kS2qdVwTRTY2OXa3CeEeABXYHxS3/oQSkQbVvjK+Waa3frZj9i9?=
 =?us-ascii?Q?dfvwu0OLuCqeKRaPQxmZmB81O5W4cWMlqtE+wDiBM8VRWJ0o+ou1RN7EJBLe?=
 =?us-ascii?Q?WcDytkX4LqHIy6d9WYSDUSUqibrmo0Sz5UVf3ib2W7llFFBZOENcp8nsMLny?=
 =?us-ascii?Q?gqhsuTkMzYrod9YU+rPgHKpphOY6ZWuEgdgfaEfKFASkk6Kke3GmvWhHGLTu?=
 =?us-ascii?Q?fR8fKDumLwHjNb7+MyEx/He9+vhVIhOKuTDA3mfQ9923iqYp6qz8HCLwoHnW?=
 =?us-ascii?Q?Kq2PKvJRk+hgN37rYSSn666k765/AIO2do2cWDcs5krZEmJlcJwGclkrBGGL?=
 =?us-ascii?Q?A6F1n93LDKhQlrIqH1Xt0AsgauAHOOGWUauacrMa4+/z3rZ7wEjdgVXupFjC?=
 =?us-ascii?Q?xIZ+ZpEmQbOMooG0QcG7ddmq5Re6HhjR7yrPAgwo/K1j+BM5koJy1jdoQ8rf?=
 =?us-ascii?Q?NHdIbzJv5zh8tBo9GxpRuohkfPrAfxXmIZkdqzYuUpLXBcJbygNzh1qN3Xsm?=
 =?us-ascii?Q?vPy/cu67hIG4Xt+t58pFGuy311U5eb0iBgosUNSlCTwGdu2OhXRVszrk+vF0?=
 =?us-ascii?Q?OmwMH8eFZB+cQUA81zlrJjoR4XQhWqkgzN1Q2z/k1aKUyqgj8tKFNoh1+0lH?=
 =?us-ascii?Q?+fly10iEi6RDtnzvBAOFFDAZHsfvfo3O7oDycXHultvnyJubq8sWmODZbzxq?=
 =?us-ascii?Q?46FQ6vK9JIF7Qi4AlOSLKmm/kswi3FD4jiFjz7kEMX4AoUq06iFzckeoX9YV?=
 =?us-ascii?Q?43oTHeyxLEc51F1a7u+QdOaav6AvUAbo7QbaSmRwyxti4bsy0QwBLxkvJaT1?=
 =?us-ascii?Q?JXIwpPIcE8PIS3hQtgQyEwNCf4hY0u+VmJnMeCw3r+QUsXrZiQD7rqj4tEjB?=
 =?us-ascii?Q?TIB+umT96KfV7WGjZBoBCW0psuiOMiEOGCd745T2wzbengDiAHbUwkZB2cIV?=
 =?us-ascii?Q?Ow2VuI9e4Hx/8w6Z8w+GpG9xPvrqEATpWSfAEGT3Bb6H33oXxuk8Ms/bIXjZ?=
 =?us-ascii?Q?UKahTQENd0eHPaO0agtbhc9hzW3sexYn+FUeP7zGF+YQ2YfOLh8LUFQ8l2Yi?=
 =?us-ascii?Q?G3hkNW6DlXtQ3jMNlhlijwoa9j8Momo3xHQpJfD80558g1J+cVyBbPDngZPR?=
 =?us-ascii?Q?87wAUh9v4A4KONVnRkKlFx+ZyqTKwPwfMf9NFfqcqE4+BoZfP2f1kw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR06MB5579.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?I87e7f7yztUOGMMjpBL2FOuxsxUHpyXgYgW0lT+juVMN9aNM7JbaQX57eIEz?=
 =?us-ascii?Q?vNxMA3eolKqPq1EL40couWNTWmLH0+HXrZgh4Fqb0AnysldSWuxcpWQxECIx?=
 =?us-ascii?Q?dQ2xLmhNUnQ8FkpzFaqC1Ea35E+3T0g7Cd6x3jTMMwuksJK/UEuj+RJnqTm6?=
 =?us-ascii?Q?WKijjd2H8+iDsQaajNVxa+kgkpVjSUlY37sEdDByy6tqtkZZLZ16IAKXSrk8?=
 =?us-ascii?Q?JPEizES2bO6Vo98Fpv8+kjT2uTgwl3pmIcF2n+nszElpiriYW7yer28uLCUb?=
 =?us-ascii?Q?yCeyPvpg4R61Otg3OSIpVro4F086fAsJqWnwrJNmMLDKYGhTSfg1S5VQFr6F?=
 =?us-ascii?Q?BYGOFhur0Vi+4EFcI1E90zkGjwWCaLh+rioOYdZILwDxnrVAX0aNIMackG2x?=
 =?us-ascii?Q?Tdcn07ZvrPIWuD2fK0da+sc3BZ+iwlT0Z96HT39cKhOqAIfVmq3Vev/xfog6?=
 =?us-ascii?Q?p8CUdEbVynmotW88ESP+yktP2TgsB2z2Z88hcU1kp6OJJQCbxGoAqUYKV+qg?=
 =?us-ascii?Q?LeE4gLTI2V/MoVGxRYnm430sog0qS9ASn8AnJ4QHD9MoCYjC8dwNMbXmQ6oA?=
 =?us-ascii?Q?cs54/irvnJYvDQmZFCWle/LOv4EU9l2DN0n2YMNRLdD2KvneBA9Tsm7a+74P?=
 =?us-ascii?Q?tV7JwVFEmg2KbxOt9c3hCM5fMebV+8Z7TG/ZfNMX1goVmAENJvCotOXsEX7l?=
 =?us-ascii?Q?Ali6+svN9ccDepB630DJrGsQ1wscLL7hVTBjA5YCF5PjdIaa73JIBJlfcu49?=
 =?us-ascii?Q?ye/vBEsOD981ND5KgQ29QKYH5kGQDijcdGauZ8xCdosFwchlezouEtGvhl59?=
 =?us-ascii?Q?ErI6Nnm8hPCsiV34my7R7gXHvkEkzMp7zTVdsMcaiiQVZ99aZTulTBG7+1rI?=
 =?us-ascii?Q?eLmGAccMgeF2ZSgl3l8frdI5AUPvFDqvi1fLo7EIz8SziqGuvSdG0genw6yI?=
 =?us-ascii?Q?Zb0kLo5cTCJaueyZhFf6QxIljNCUD8YWyjW+G24Zyxp0UwQdOqUK5XRVVIEs?=
 =?us-ascii?Q?Fkk6TtrF9DkhK7yZthlbB3v4IweFW+sbOayM5aypIbX5GmZeyi+6GrJMyxWQ?=
 =?us-ascii?Q?dmG2un13omyoH/dF/Bi6ZRfYCXzYwA1hU5jRwdw72RW0U5Bz0WqHYlgClaqP?=
 =?us-ascii?Q?AHM608xqPeSvWJta2HI656TMiiEFMy6ntmiRNJrlW9IW5xecIIrYUhW+3GTe?=
 =?us-ascii?Q?xAoBKirQQEe4rPG61qS8sWTJMlk7lIEFr2Hqt/JTXWC0XdZOHTK6cQCTXSXV?=
 =?us-ascii?Q?8oOqfS+90OHS1AoOrM65vvXPrEGwd21Nlv58DfMCx+q42FF0TJ+LdtHxwCRv?=
 =?us-ascii?Q?99lTHdwRbFIT22jKFyR9AYtNNcwl5KwEoIbyo5PWrMqc56jjqs5Hh7ofFRzx?=
 =?us-ascii?Q?py0vdxAY4tiYQUdF2FTHg7gzmOKZWHq1hjwn/JqU8bjnVU4LAeHFgBrfYD6T?=
 =?us-ascii?Q?1FYtzE4yckYpoZ3xm8zMtuzvvIzyHPTAhvJua1+2JYYrANVNqnLoudzHnjMn?=
 =?us-ascii?Q?57jpCChwOIH/A1z0/FYaPuf/4bkQYFGmB8Jm/3bAhyFHr3iF8C3AB+ehHu1j?=
 =?us-ascii?Q?zDOA5iVn5DZfyJ8eBulQUjyjlIrKCW0mJJfmGurT?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12bbd6c3-bfbe-4898-c6fa-08ddd4e6ee37
X-MS-Exchange-CrossTenant-AuthSource: TY0PR06MB5579.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 12:44:06.4196
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sChxcI0npjfV5JrXz9pSwIRxopChxLlOPNdhImZgfSlujOVK8JhzFy9JgONiFZeLlAfPgTz5qQyDchvC3HgS3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5305

Replace the original swapping logic with swap() to improve readability and
remove temporary variables

Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
---
 scripts/gcc-plugins/randomize_layout_plugin.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/scripts/gcc-plugins/randomize_layout_plugin.c b/scripts/gcc-plugins/randomize_layout_plugin.c
index ff65a4f87f24..5d6ebe292cbf 100644
--- a/scripts/gcc-plugins/randomize_layout_plugin.c
+++ b/scripts/gcc-plugins/randomize_layout_plugin.c
@@ -199,17 +199,12 @@ static void performance_shuffle(tree *newtree, unsigned long length, ranctx *prn
 
 	/* FIXME: this group shuffle is currently a no-op. */
 	for (i = num_groups - 1; i > 0; i--) {
-		struct partition_group tmp;
 		randnum = ranval(prng_state) % (i + 1);
-		tmp = size_group[i];
-		size_group[i] = size_group[randnum];
-		size_group[randnum] = tmp;
+		swap(size_group[randnum], size_group[i]);
 	}
 
 	for (x = 0; x < num_groups; x++) {
 		for (index = size_group[x].length - 1; index > 0; index--) {
-			tree tmp;
-
 			i = size_group[x].start + index;
 			if (DECL_BIT_FIELD_TYPE(newtree[i]))
 				continue;
@@ -218,9 +213,7 @@ static void performance_shuffle(tree *newtree, unsigned long length, ranctx *prn
 			// we could handle this case differently if desired
 			if (DECL_BIT_FIELD_TYPE(newtree[randnum]))
 				continue;
-			tmp = newtree[i];
-			newtree[i] = newtree[randnum];
-			newtree[randnum] = tmp;
+			swap(newtree[randnum], newtree[i]);
 		}
 	}
 }
@@ -230,11 +223,8 @@ static void full_shuffle(tree *newtree, unsigned long length, ranctx *prng_state
 	unsigned long i, randnum;
 
 	for (i = length - 1; i > 0; i--) {
-		tree tmp;
 		randnum = ranval(prng_state) % (i + 1);
-		tmp = newtree[i];
-		newtree[i] = newtree[randnum];
-		newtree[randnum] = tmp;
+		swap(newtree[randnum], newtree[i]);
 	}
 }
 
-- 
2.34.1

