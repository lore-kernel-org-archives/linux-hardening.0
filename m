Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011027.outbound.protection.outlook.com [52.101.125.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC38516B3A1
	for <linux-hardening@vger.kernel.org>; Tue,  4 Mar 2025 02:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741054522; cv=fail; b=beMmtvIwcVkDa+BP2EUYBmw8XdCYdmhStboiz39iqpTESp22gN8An6sHGed9muaVKwBVKXnLQ5eqNguePIE9RVXI4O3Oza/Bwz9pJcA/ZhZXjDn/gYPr1gDZCVk919yEwJYH2Kq97fpWAA/VdPyMSKjlt/IZrjohBbHDuMROURU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741054522; c=relaxed/simple;
	bh=Rg30cv9xNBTeVwCf0TlSefyDrt3AJ+Ij58c5aRyCBz0=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=TrG60GB9vZJw3OPhTOyFHI0Ixoe91K0FNjxTMkW53kWD+dD8Dn7peaPvkBWsnhjiyoameB/ZuV2SgdteKETyLM9RDGsOlFY/KCGgQybBAIaYpEELIYN7s5zMJxP4IanJaVViJuF8SDlDrXdt4ZFP7cQYz2oC9quBPOROtZEkAjQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=JVDkAUqV; arc=fail smtp.client-ip=52.101.125.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="JVDkAUqV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DW8bHon8gOyVvYa40e1zMlOEMe4S1vm9AY4iAc8UbA175eZ2ZkQcdFqdfXP9M5r2fS/dw+LfsH03xScAu07F0kbD2zOyxVu0eRDI+ApkJ9whzijCnRIboUVmqUqXOLkr72fyjDfbdFembUq+WS+HYyr8m45Wi9guOHSl3B2K5RFwZpW2Vok7szLGPd0IS7huAVXIVfkkanHWsGyuANnzQn8qjE8Aw9wkALJN22a2zHewpUxIgOksIxTTFD1pWJ0IwLeSluhgqPR3Vo/QVxTOfcNG6VCcxwUQugHVTAeKPSQgGVG27nPmCx40CY95CTnO3czpH3enBuomWu+I17KfSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5jEM+Nf+jAt9jUNkm5ZNME3dvZrUMpuGG2WnBjHkZdI=;
 b=SHtOiof35FrN0hI9CSKW8BWYunxkgCfKGSk8kDetYAlvmoCrggZ1KEa4HDDinUA7mpWPAOMFehPKk+cGjY5Rl4q1nfP09Jrg1IhGZnT4j4WNVQ1qMu543lk7JmAGhU55Ywy1S14SMEJkfK99HaEo/89ZH3g9sYRwoNYNIR3g2uhBhA6nqWxGi/fmbvEg2D5+h9amu9Y+Y7li/pEDKcNHl6RQfVoSJ0aHMxNbpzsBYXPIH+YO1nx2Z2eBQjNMcXOaJ75Hoiv9RVYw8OMb5bB50jteZzNPgaZnQxkN3YiGGxbsK1LQ7hv7bItlamC42wTJW0WAYKt/cQEGWqi/eWsEwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5jEM+Nf+jAt9jUNkm5ZNME3dvZrUMpuGG2WnBjHkZdI=;
 b=JVDkAUqVYDeiY9To5+Q/R1SIPgU7lwYLpXR2+24KfpMIkpQcLPj2TZSpiZS4YLH4sh9I6BTCBZ9VZvcIRJRCgsO5HTr/rkvDLkx8hF34+zuHR+s7HW1P55P3+N+9rmtBSAfkncVJaal8APLP3uanq/juIt5xudpIHga1KsjeSTk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11) by TYCPR01MB8061.jpnprd01.prod.outlook.com
 (2603:1096:400:11e::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Tue, 4 Mar
 2025 02:15:17 +0000
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11]) by TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11%4]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 02:15:17 +0000
Message-ID: <87a5a1pmmi.wl-kuninori.morimoto.gx@renesas.com>
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [SAMPLE] accel: habanalabs: gaudi: use string choices helper
User-Agent: Wanderlust/2.15.9 Emacs/29.3 Mule/6.0
To: Andy Shevchenko <andy@kernel.org>, Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org
In-Reply-To: <87v7sppmqu.wl-kuninori.morimoto.gx@renesas.com>
References: <87v7sppmqu.wl-kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset=US-ASCII
Date: Tue, 4 Mar 2025 02:15:17 +0000
X-ClientProxiedBy: TYCP286CA0064.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31a::11) To TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB10914:EE_|TYCPR01MB8061:EE_
X-MS-Office365-Filtering-Correlation-Id: ee146bb7-9a33-4da0-dc57-08dd5ac26849
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FuAUqsFmrAV/8vWe7U3T4qGQ+Rga9k7RsLLPv/KlexeMllZbxhjAjnjtQ6IN?=
 =?us-ascii?Q?cgiTzz/s8fYaosxSWpKFzQ+G1dCoSPRKelLpSqxElgvFZXtwU+9iiYDiqy7W?=
 =?us-ascii?Q?ffBsHu2HfojAhAlCw8/Dkmr4K/894xHYcySk8IHA4f3ulYB0x66S5xGIP2X6?=
 =?us-ascii?Q?U6C01INCh43z6PK8x6nwISb37Xna3eOzsH4HvH+/3wWL59WBTa3nBYjkts4M?=
 =?us-ascii?Q?uOlSUje9S8/65DFiXhSzbmBgcIfbp1ZVs8daPV/lg3wiAOI+yuYxK9rQm7ps?=
 =?us-ascii?Q?nOWchuWJceKYbxtuzTGrfbpRWceJI3kcYlGnHf72IzN1NbfxTY+zIHwMJMKc?=
 =?us-ascii?Q?KXt9aA4wPkY60/PxBs6tSqVQcO2aDK2tcYNqk3YLVkzr43oKAK4mNKpf21II?=
 =?us-ascii?Q?GDZqIj8wbgNDXgZFlx3NaENzS2yj3niA13/mAkmUmxUIV29T+3UpkzSlhYjK?=
 =?us-ascii?Q?3grOblnGE3y/5GVsC1pieBfSDK2Fw03c9VlXjmX4THgYbtH7SiKqbvqyNuZm?=
 =?us-ascii?Q?wjkIVrcDYzlvuZydVzuPHOJVzYdPlfvbZOC9/A2Qt+2cnvWp3tlnv+vUYPFP?=
 =?us-ascii?Q?lKNyEyrRXBs3HhEcO9PGwVvi016FHEH7mJ2xNzIMS1bQy2on5vZzshmx38fl?=
 =?us-ascii?Q?duTe02vGFZBN0/pt65gv6ydjCpeO9OF91PuueMBtSXHxWqC75mpGZJhBHR9a?=
 =?us-ascii?Q?IqKXJO4koyW6iEOjYw/Ew4mT53osvqzlPwGQcE3OJM28cSpco3iGYN0lvOPs?=
 =?us-ascii?Q?lUPQx2940uOusT5xb5sDa2uSEHVXXAhYsjnZJPh0x5C4WcjAiIUAsIVC4/0H?=
 =?us-ascii?Q?k3Xe7UkA7/8xmTbv5Be4ff2TAgIeA+nVFOIvraFL337VJZcnjPK6UiJ+dOb7?=
 =?us-ascii?Q?+MO1G7DLXQtNSwAtt02vK9MG3eZuiO4yeRB0xciFSaR8Ez5wN/o4+qm7l8Xj?=
 =?us-ascii?Q?R3s6CAf8uXwHEESlxEMehVHkrSmvOGRa+nMgshg1nlLuw9PCWl+dURqs2PJL?=
 =?us-ascii?Q?aj6DeQ1QF+DIJ9FzoKpX73/KTQEsYjBrpzc533cX9lCgX8zRi7IuAEgwz9Np?=
 =?us-ascii?Q?u6oJ1jfhOkSTuKZ8IpiLzs/Nf+Pd+DHOtqxU4Pk8dQP5uHDcygOQ745nm1Ie?=
 =?us-ascii?Q?L5Pyboy1uRS9IXytwsMOu43jIfUZNLdX8IWVdNYXYvVApYGEHmnmbPIsLRqr?=
 =?us-ascii?Q?pUSXDvnCrD9/wqjCPCtBpefVdk4B+1TiD59hJjM2C63Pn9FuEUCJ4xQkO8yu?=
 =?us-ascii?Q?cG8ezh736K2BHjvxMfoL4Jhyfj6guL7b2jsOwic8XZZhW8SK76eAsZwqMxEu?=
 =?us-ascii?Q?ZzWC7uFR8EiJQF3Noy+RMFQE651jjq9j0uHjFQ6OUJCtyqeNY4p8O9RR3ftN?=
 =?us-ascii?Q?74/q+OojEqdTsCUUb+IZWXcC46DZIHEGiC0VTRujeuu8gwdWfYXB01OfZzL8?=
 =?us-ascii?Q?pq53Nax2k/btI4ouJC36O1bwwoLGO9V8?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10914.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Q+DgYyWr6yBnvCr/iUc9A7ARs1WTaNNEoQswKWBdfZ3C7IfeMVWmQh0GQLQU?=
 =?us-ascii?Q?kB+wc6y2YF6WnCTtyp+/gA1GzMC+LCB2gDAXVTNIoEjfp4M3vumwErBiBpN2?=
 =?us-ascii?Q?1TkBWLyYHkHoY7sW5hwmgTRvvMy38VqJNAi3mIsq+Qf0AsQ/5HHw8NIi17zw?=
 =?us-ascii?Q?Kn4GJRGaxaeL/l60/sWeEUZjXrkHqfrt2TuqEI1OHok5SB2uNB9OC7rPgszU?=
 =?us-ascii?Q?BjIpuruJxQddpShbC8JAgdXEpWONvE+5RQxye3IzOvGy+RuJQrYlVRiun5+u?=
 =?us-ascii?Q?Y+IusPNhFK3IkGDrEShUNh3w7AWpuL/m38+c7QGNYwoDum7n2Zt4tRMRH8hI?=
 =?us-ascii?Q?TrpNLeZTIu+zfFyX11migo++Dk7IQcWxd2Eh8LdejhLXN9mxUYYJ1hEXuIQF?=
 =?us-ascii?Q?/x0DHaE6Kokmje+mcAkVnJNw7eEFoM0kz2XX9VCcpQTcjiDE6zGU1I3mVOGl?=
 =?us-ascii?Q?ruQcm7MG6R4VCPfXO4OBBOY0ToHpg4TDRYSAcmcqbZDcAdZp78WXPKdtN1U5?=
 =?us-ascii?Q?LQuk26NGIamP0EYCmHFChbGFvUA/rU2r3hSNqgyIhVLtX3oLID1VRf3uQnTv?=
 =?us-ascii?Q?zJstLN+g5IkwR4LYdBpVdIFQ4TiATuXS0v8wP+9G9DIhLYBzeyBetQ9+w7cU?=
 =?us-ascii?Q?6aBRxtbkGa8CnMzxyuL0Z+s9roxPwFLqW2ajWPM1v5c2ur1OGakPVY3nPy2Z?=
 =?us-ascii?Q?q7JgnGZccO//B9G0OOJVtK66DDpd7rj+PoNK4hteorUKoJUlOJP1YaceWZT7?=
 =?us-ascii?Q?krCVYngPHSjqFfk4xZMPREyCZSFJGB7OodhMQnJHjTb5eBBJUQr1AIOFNJe4?=
 =?us-ascii?Q?RkePvxA5Lev4HpORKNot1OkwhzSNz6BEg3dIp4Ow/hojgmc8qWKBhNaQS3yn?=
 =?us-ascii?Q?swYhtj5Y6V0E9XQFF+BXJ7F3/4GPDHSl2rid4PYGHgsoWhfptZcGQ2JveoZV?=
 =?us-ascii?Q?6nJ6JFKJQvLqvIZlWoA39F4gSqZaCQOzwyCbv8PkckOoVy9kNPDe3c7S95D9?=
 =?us-ascii?Q?gR/vWPVg8+llgESXKMcRTR6TTqxuXkhck04WFOaEZos43zbiySF1xgQQlLjd?=
 =?us-ascii?Q?XhkgCeotKK16EDRXQ3kQLLz19TPhCZuXRqgk6r9zI1SRV9sxXj5bbfyS4dCc?=
 =?us-ascii?Q?2lFBmJqS3TihmmLR4HHUIpWNnC/nij9vOh3XptszA4mmvrzsbOYq9vjyiVeo?=
 =?us-ascii?Q?TK1VfGnxOXpUGqHmuDX39u+CB70GH5RczsnjGC32RTnryo/FF2VnplWZAYFA?=
 =?us-ascii?Q?1zIvVu8LUBR7zOeFTbjYVBp2jvktujyedFBhKocIjgSM/hGt8dXmJEBhwsG0?=
 =?us-ascii?Q?3SMIlrnr07tcP1L++u1NOHqmxpLMXQx0gCKhoigbXPmKl72wZVxKGL1JPtda?=
 =?us-ascii?Q?aPhJ3Ewz7vDUD5UxS1xJHX3UqElCsvoSGFscdhWn3Ab8DIAXPWf3c8NECakr?=
 =?us-ascii?Q?YsB8KyDi5Gl05OKVrpWVSjgcVMt/u4AfJPJUGFv9iNsrG6WG71Gc6p5OCyTr?=
 =?us-ascii?Q?xko67CC1OVPj2s6bUmMwz5/6ZhytS72kBDoTE9TcQfaUpapb6ByurKaH14A5?=
 =?us-ascii?Q?0bHHxCzIRzjd2iqxz3Jp56cQ/BtKeFBT8CPKNKGCVyNuSLxXgQ6Vi+bHFYVe?=
 =?us-ascii?Q?hui9oRg5Y2pXWYmJs8eYY+w=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee146bb7-9a33-4da0-dc57-08dd5ac26849
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10914.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 02:15:17.7498
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GaINYVuM4HOYYGknsh2EKFg9nktITR8iuPgzg19KxUeqSjvhq6EV/3pOoiKGzz/JAJGrNoYb+xVGCHMq7WSeR8YW3zOqrRjMeqN6ePyFiKcjo4ihBy8MAyxqyKssSD5g
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8061

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 drivers/accel/habanalabs/gaudi/gaudi.c           | 12 ++++++------
 drivers/accel/habanalabs/gaudi/gaudi_coresight.c |  8 ++++----
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/accel/habanalabs/gaudi/gaudi.c b/drivers/accel/habanalabs/gaudi/gaudi.c
index fa893a9b826e..05d7b15bca28 100644
--- a/drivers/accel/habanalabs/gaudi/gaudi.c
+++ b/drivers/accel/habanalabs/gaudi/gaudi.c
@@ -8037,7 +8037,7 @@ static bool gaudi_is_device_idle(struct hl_device *hdev, u64 *mask_arr, u8 mask_
 			set_bit(GAUDI_ENGINE_ID_DMA_0 + dma_id, mask);
 		if (e)
 			hl_engine_data_sprintf(e, fmt, dma_id,
-				is_eng_idle ? "Y" : "N", qm_glbl_sts0,
+				str_Y_N(is_eng_idle), qm_glbl_sts0,
 				qm_cgm_sts, dma_core_sts0);
 	}
 
@@ -8059,7 +8059,7 @@ static bool gaudi_is_device_idle(struct hl_device *hdev, u64 *mask_arr, u8 mask_
 			set_bit(GAUDI_ENGINE_ID_TPC_0 + i, mask);
 		if (e)
 			hl_engine_data_sprintf(e, fmt, i,
-				is_eng_idle ? "Y" : "N",
+				str_Y_N(is_eng_idle),
 				qm_glbl_sts0, qm_cgm_sts, tpc_cfg_sts);
 	}
 
@@ -8088,11 +8088,11 @@ static bool gaudi_is_device_idle(struct hl_device *hdev, u64 *mask_arr, u8 mask_
 		if (e) {
 			if (!is_slave)
 				hl_engine_data_sprintf(e, fmt, i,
-					is_eng_idle ? "Y" : "N",
+					str_Y_N(is_eng_idle),
 					qm_glbl_sts0, qm_cgm_sts, mme_arch_sts);
 			else
 				hl_engine_data_sprintf(e, mme_slave_fmt, i,
-					is_eng_idle ? "Y" : "N", "-",
+					str_Y_N(is_eng_idle), "-",
 					"-", mme_arch_sts);
 		}
 	}
@@ -8115,7 +8115,7 @@ static bool gaudi_is_device_idle(struct hl_device *hdev, u64 *mask_arr, u8 mask_
 				set_bit(GAUDI_ENGINE_ID_NIC_0 + port, mask);
 			if (e)
 				hl_engine_data_sprintf(e, nic_fmt, port,
-						is_eng_idle ? "Y" : "N",
+						str_Y_N(is_eng_idle),
 						qm_glbl_sts0, qm_cgm_sts);
 		}
 
@@ -8130,7 +8130,7 @@ static bool gaudi_is_device_idle(struct hl_device *hdev, u64 *mask_arr, u8 mask_
 				set_bit(GAUDI_ENGINE_ID_NIC_0 + port, mask);
 			if (e)
 				hl_engine_data_sprintf(e, nic_fmt, port,
-						is_eng_idle ? "Y" : "N",
+						str_Y_N(is_eng_idle),
 						qm_glbl_sts0, qm_cgm_sts);
 		}
 	}
diff --git a/drivers/accel/habanalabs/gaudi/gaudi_coresight.c b/drivers/accel/habanalabs/gaudi/gaudi_coresight.c
index 1168fefa33f4..3497768ffc0f 100644
--- a/drivers/accel/habanalabs/gaudi/gaudi_coresight.c
+++ b/drivers/accel/habanalabs/gaudi/gaudi_coresight.c
@@ -497,7 +497,7 @@ static int gaudi_config_etf(struct hl_device *hdev,
 	if (rc) {
 		dev_err(hdev->dev,
 			"Failed to %s ETF on timeout, error %d\n",
-				params->enable ? "enable" : "disable", rc);
+			str_enable_disable(params->enable), rc);
 		return rc;
 	}
 
@@ -505,7 +505,7 @@ static int gaudi_config_etf(struct hl_device *hdev,
 	if (rc) {
 		dev_err(hdev->dev,
 			"Failed to %s ETF on timeout, error %d\n",
-				params->enable ? "enable" : "disable", rc);
+			str_enable_disable(params->enable), rc);
 		return rc;
 	}
 
@@ -601,14 +601,14 @@ static int gaudi_config_etr(struct hl_device *hdev,
 	rc = gaudi_coresight_timeout(hdev, mmPSOC_ETR_FFCR, 6, false);
 	if (rc) {
 		dev_err(hdev->dev, "Failed to %s ETR on timeout, error %d\n",
-				params->enable ? "enable" : "disable", rc);
+			str_enable_disable(params->enable), rc);
 		return rc;
 	}
 
 	rc = gaudi_coresight_timeout(hdev, mmPSOC_ETR_STS, 2, true);
 	if (rc) {
 		dev_err(hdev->dev, "Failed to %s ETR on timeout, error %d\n",
-				params->enable ? "enable" : "disable", rc);
+			str_enable_disable(params->enable), rc);
 		return rc;
 	}
 
-- 
2.43.0

