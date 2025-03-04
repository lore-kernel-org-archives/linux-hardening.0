Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011021.outbound.protection.outlook.com [40.107.74.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06AE013B58B
	for <linux-hardening@vger.kernel.org>; Tue,  4 Mar 2025 02:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741054440; cv=fail; b=gqo/BrA+eoD/84LVtrq056aCPw7dB5zEdfuzVuIb6sPJr4DhRdiYi6hxiqX2xH8R8NUnjPgRAHmiyVGMYxZE+XVWFbLBeshXhEgWYZqCJNn11SRToikRzr3dZP0beh60f94PpV9tI2HxljOF1yzkVCaGJM6QTHv/E4klA8FHIug=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741054440; c=relaxed/simple;
	bh=oowD9iNpWsI/yqaVGvyt8JTQP8/BmwcUkAqcQICtz/Y=;
	h=Message-ID:To:From:Subject:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=DCmMVhSEIB6yjUYhqG5U31RtsiQo4rKhMRKDpc9GJYcxZ56SyAnBgr5iw9A+v08qoGegoYf9mkGigEnW589zR8fkHfhOPorcigFixU8zmOa0bRmKESv8RA72R46BIYrIqOKua0Tjb5GcYre6HDRoXwzwW5HEsg5zwt2WzmRxWiw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=eoUcRKxM; arc=fail smtp.client-ip=40.107.74.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="eoUcRKxM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SWXlWDia0Pwnwa5swDqcAwCCn0XsbIxVGLZFkWTyW30/5vGMCBSuJwdpPQqxOF6fpzDj3lmFIAwKAOG/jL6PPC+9kHnItgYBUFW1vBsTjawIxkkVSMcf9eb8qzWlodCd/50fy45UFrlw69JLfXq2/0pUxAiCCwN3Kc2jgmFZH80OAgCJ8laqfvatZIlmGRFuFELNcMtgKOFd9DrP7sb4gFiy1dsRYokDvJWI5ntpEbaAfRzOli40k5sIPN065rRVUv4LwnUPGPQWMylhayKzVwzVXk4zPW7zNI4IQAhiUQhOPLP08hlgqM2S1X3wpvDe+9c0ieRAE4et6zcchjv6Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B9sgA8TYYOlUt7suDkDrmwuZTF+NpaHkZBliS1pAKRE=;
 b=q/BanO9mVFYW+mPsaBqC0MupEyMY8CdRcmVxrAmMhQta0eZ+ZqVHtUw2OA7cz4tUqW1A+PsYwNOvLfGJu+e/2bWFfLKaG5FXfjCNv0XlyC6oejWcmL/bwsXbCCHYBXTaMXDVz4wt3vDh26SaFiC1kfIkozCxKfFuCZV6McvmpwXJHq5/45EavTQwcOamqhxJ0HeENawI2Sss15R7WfncQdWQM4Da6j9wORk6RrkQK5gzp3WoZ+kWCa23LZO4tsZDteU6BAK2WdkMtxNigtdmwzkj1qToCZea0bhjO3Knq7YKaoRm6WtVMhMcr1t24zOHGQo0rrekDV0vhlNWKmSnhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B9sgA8TYYOlUt7suDkDrmwuZTF+NpaHkZBliS1pAKRE=;
 b=eoUcRKxM+4Wr5PflXKjmciNNESmD1dR8gbzkAVE9dT3rf1mGL1OLKebY6qzpNJfD/XZ9u4GycSXJdF2ZHVVKjbf4LxEVKWYFbZuwq5QfCF7pfQR4ruem2mfqGiQ5mINvRna1BwebFHcz4rBsDBUez5CueBOp3MPJu0dFTmNy8xA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11) by TYAPR01MB6220.jpnprd01.prod.outlook.com
 (2603:1096:400:84::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.29; Tue, 4 Mar
 2025 02:13:57 +0000
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11]) by TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11%4]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 02:13:57 +0000
Message-ID: <87ikoppmor.wl-kuninori.morimoto.gx@renesas.com>
To: Andy Shevchenko <andy@kernel.org>, Kees Cook <kees@kernel.org>,
	<linux-hardening@vger.kernel.org>, Andy Shevchenko <andy@kernel.org>, Kees
 Cook <kees@kernel.org>, <linux-hardening@vger.kernel.org>
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH v2 09/10] lib/string_choices: Add str_kernel_user() helper
In-Reply-To: <87v7sppmqu.wl-kuninori.morimoto.gx@renesas.com>
References: <87v7sppmqu.wl-kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset=US-ASCII
Date: Tue, 4 Mar 2025 02:13:57 +0000
X-ClientProxiedBy: TY2PR06CA0045.apcprd06.prod.outlook.com
 (2603:1096:404:2e::33) To TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB10914:EE_|TYAPR01MB6220:EE_
X-MS-Office365-Filtering-Correlation-Id: cf4c82cc-cb61-47da-1e58-08dd5ac23848
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?R35MvYaagHTBu5VMdNuMufAggoZ0VnfkOHEAOYphnzTtPMLrLfg1jSqUS+yr?=
 =?us-ascii?Q?5BKwxBHB1U6HiSxztyhQdudBiEKlc70p4dAuqxCqNivNvJQ7i6c+MaFgvI8M?=
 =?us-ascii?Q?iMcT7OIiGc5dM3WtBFp1h2Uwr1nKOoe8f1LoeuFxIBHMDdz6RLyV53v3pI9D?=
 =?us-ascii?Q?B+MmsD4hNaCRg5OP76LHqxnAmrVHbWehr+5lpN4rvdZpE2x067KMbRHsnVSG?=
 =?us-ascii?Q?4gpYITmdmclZeeB1MpdChZFLtmMCaxjoCYE6M3PJGQL01CNPR9tqseC6uKEM?=
 =?us-ascii?Q?ABnNJ012Hk6pFUr/XdVjwST/klVDj5J4F71/bZm5hnBG67l39RDDi7bu85P3?=
 =?us-ascii?Q?AxmZASdR2DQOnZhfX1G/5vqg/ilTZqfDuaIYheeIgsOiYYKDEUwHbqPICFh5?=
 =?us-ascii?Q?J3aq7QAfYJnp1d2zNGGEE/0tWA6gNhPVamEnqxWhYw6s+JGto3vNWf5oZNPS?=
 =?us-ascii?Q?+NUjIcfcVdfvtm8JBXWzs2D+XrolU8y/zZKIZFl5nB9g7PlluQYSD3MZdjC+?=
 =?us-ascii?Q?hDCjjcPVISPmKWvBAc7gVopkRFIXYaPIV1VmMX3W7aogsDGQL8Lbe8ZZKid7?=
 =?us-ascii?Q?PVg0mU05qdJPsa4E9qV3ZBbihYC8kvhIfGkeH29rho7t8IHUPcxejtAcIFGx?=
 =?us-ascii?Q?WXBPcmDxtDRoScVwqoLyY9cKtGk4oGkRk8stFV6z7ao9lLQnU+73nmE4D4A8?=
 =?us-ascii?Q?CK2yJNAFW65+4HWPaHQ9oGsDxpncr0BR/yC9wUZGoLo4QPJ8fmcWf5k1DpQN?=
 =?us-ascii?Q?WyWvqZlD9zr/Tdtor95FuQoLKG1JhpBnEKuqLRp3lpxWs8sTN/DVDScsEeop?=
 =?us-ascii?Q?7DUZrn4vdrXLxI/6jqjJhDZKbTIIpfL2+bTew9oQ4tlVQuF98mVgqapqIQP3?=
 =?us-ascii?Q?e2jCP4KFwfuEvt/2nE7buolOzez3aUfyAaC+U1aZHFXitSqf6W4wTGNj1Z3i?=
 =?us-ascii?Q?+PKkjBHyH0c5MWJtbZbwrKf61LLjUTH4gnhlL+v2rUzg/M1QIxLcl0J6C8AO?=
 =?us-ascii?Q?VQ1gEiKy0ghJMyIK8YToRDTa7cY8BlgT32r4/wuaIeg/0yzYX2UwpSO8cr+f?=
 =?us-ascii?Q?8HeZQwZpPoiC4dpSVaLPeBn09o5Y4lEP8O1Yh/7mXI62wvaeGfI7QUWOWw4y?=
 =?us-ascii?Q?xVJB4b29IQf4NYMq4wXjCl7XLgox/DvtVGZiOPsiBu1+Kexd4PjfA5YE0PQu?=
 =?us-ascii?Q?rS77ASLR/j1pwJ/d0Jugaflqlnq/8EGWlKfjqEFUVBfqaVjG6MGkNd83vk9r?=
 =?us-ascii?Q?IUSvQjpJgNelKcn9lBhB7uMSYlneA1XO0mv9F6iBnDDI9dHxJKhmRT/FEwGE?=
 =?us-ascii?Q?wFKkQcBhE88yUkc0J0q8cv2g9savFvNcxh88sDnzMoOShU2osh5di80ijQZS?=
 =?us-ascii?Q?A6hpQBBz4n0ulPS56MyrlVoV9nfx5gvyKzZei01fN81rS+CYZ5V7kAHKJdz3?=
 =?us-ascii?Q?Ew+VHAxXdbm/lODQJWux8R3/j8OuBL4m?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10914.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?myLUXiDFa+D8RqQn00zCqQUtOEqa7YGnFF0bG4Q9syPQnW0C4SnsaHVDp576?=
 =?us-ascii?Q?VVO8JE/vNm4Q7nCYpfvPst0vdzTZmZ1QZIE23bgOspzXBbgn3BT/iXJgNwN2?=
 =?us-ascii?Q?2w7TR1Aa1BzRnPDbCJ6cel4+p1YZA7dE5LUjiKn09hHUG601rS46BhjwcJyo?=
 =?us-ascii?Q?aEWZbx15cGpXRgMJRwaHzHmSiK2DDZ+8b39YZ/+NS4aCnd4bzQYlT4nZy+nr?=
 =?us-ascii?Q?IjT7iU/mcbikGrr/iQ5ZQLp0gZBwxU0Eg8XlAh93H9QPPYwgfVjMVGMH7WNs?=
 =?us-ascii?Q?oXCm15fYVYNGxbTx3bM+lBuhi4jpoGpn7dU/uWV0AceAV5k2hGXDTPe9EQNR?=
 =?us-ascii?Q?Pd+NQ619S7dOAZeBvgQU0pr2FwqVNGP35mOU5dvAtlVOw1gU0LKKqF7KDpz3?=
 =?us-ascii?Q?WHhr+0s7zE4xGk18RI9o/lhYXr3zRk71ZrGqJ8mTY0XW/AN0pEHIYCxkq2KO?=
 =?us-ascii?Q?dRQCAEnE8sTKSJPSfJSe4CZGDoJKjiDQcmfENSMw66PlyarnIc7apOYa/P4G?=
 =?us-ascii?Q?5rGqkGxWOD56BeZJ46qqvEjUQZg1XtVxxZ2x37Z5K0XFY17ucDGDsdRIzdup?=
 =?us-ascii?Q?85r111tTFFY9jD6SJpIjmzL5vVQEKQtQsD83gjpW+WENapUlZwNnDojANErA?=
 =?us-ascii?Q?RYhyPTgAC/kxCwtf5R9LOnbjLczVTFYhJSDiq/PI8QpHfkW8poB7PGHYycR6?=
 =?us-ascii?Q?0hkHZ1yAowge1rB7Xq63f2zBXAIBvJUgpljjhFQw0zXBYEHJx6cMV+Yfw0lb?=
 =?us-ascii?Q?mMipKMVe+dlLenFgABU0fckeNtnSNvq+hbdYbt4p2R3FOvVXquTR8itjAeum?=
 =?us-ascii?Q?pwfgOvwr/3WRLSA3IOyyJhw/rv/woPn+PVOGO18GqJjt3WwRoUe4YGrtsKIt?=
 =?us-ascii?Q?pK0BQtheAiB0PMoi5W2PH5azBCapLKItKpDirH9etOuhIJD6gRYsta9r/BFJ?=
 =?us-ascii?Q?cVJVKtuTIMw0ugBMNuOs2y1d/HWUuvcfvPS1TJQQlbkzBH3s2fEiYrQOK/5v?=
 =?us-ascii?Q?Trfn/7SKytavv43fNWyjW/njvILz/Q3lLAJVC8nRXbf6phq6IzgRvZn05zJv?=
 =?us-ascii?Q?ByQgKU2J0NMqjceYW7xL4HAFN8l+F8Dx2ANIz17s+z8kloDhLjL+Z/ykX5h2?=
 =?us-ascii?Q?wnVBL77cc7CcZFBfHOmXucVypaGMJzVPKaLJs4ZUB7SZUjjtbOujTLiLngbI?=
 =?us-ascii?Q?/eL4ut43I9HhU7LTjPIN8lT6SKIYRtYNLWw04fqkRUuBXbgmMdXM7hRw+POa?=
 =?us-ascii?Q?YQGMJXdnGptxpGOcEwAq7CocUa0Rnpe7Izm9Olw40OEHsLyNlZRRI9iTna3D?=
 =?us-ascii?Q?+Z5pfo6y09yJ4q94oBSoyj0yEuaS67QkRFgf4wtlx40SISwJ5E/HkwO8xCHC?=
 =?us-ascii?Q?NbQJMTafMYb9FlU7+arJSpktRxkSa1IKCoXRQJf9v770BGtrZI0yURQNBUzN?=
 =?us-ascii?Q?qd/2hglf9WnO4Smy973SbDuMgm+jJX17ZyMysCf4upWZKIdFdblvAptBp/YB?=
 =?us-ascii?Q?3sXDHnYjf2ylepsDvt4kURD2tarTGXc1OnCk12F/TsUU/3aJ2xzaWtxxMzp5?=
 =?us-ascii?Q?OLBApJTf2cGg+CGpUZTNLsLZZVk4xrQv3bwYmw/k3IxO1qVnP1VJLr9GL0aV?=
 =?us-ascii?Q?ZIXuFywyTaBYlBucUDA3c/k=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf4c82cc-cb61-47da-1e58-08dd5ac23848
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10914.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 02:13:57.1920
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8IHVvUJsr/j//0bvSICqGV1xep/cKAtvzT2u3WuwEUug0PoWpbNe80Q7PFufcUmgSOIgRSwknOu+eVhlQ7EVknLQONWKN6r1ePv4f9ORcJmVqjyYGByeB9yURDAhRLRa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB6220

Add str_kernel_user() helper to return "kernel" or "user" string literal.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 include/linux/string_choices.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/string_choices.h b/include/linux/string_choices.h
index 1965d3a5976b..82c5927d50a9 100644
--- a/include/linux/string_choices.h
+++ b/include/linux/string_choices.h
@@ -119,6 +119,12 @@ static inline const char *str_level_edge(bool v)
 }
 #define str_edge_level(v)	str_level_edge(!(v))
 
+static inline const char *str_kernel_user(bool v)
+{
+	return v ? "kernel" : "user";
+}
+#define str_user_kernel(v)	str_kernel_user(!(v))
+
 /**
  * str_plural - Return the simple pluralization based on English counts
  * @num: Number used for deciding pluralization
-- 
2.43.0

