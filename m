Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazolkn19010016.outbound.protection.outlook.com [52.103.33.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD7137FF60;
	Sat, 12 Sep 2026 13:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.33.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789218555; cv=fail; b=NpgE1Rj421rsLFMXSLTbBIVRLPFoKVkJVhW4eKmJJ4MVM4WuDPZGRXnzEJoXd2lSAQKPQV9SnOQdS1udCOphpajFpiXty+fhCZfb7RcGXlX58kKjXd0udkGN4Yo3vVoo3woEoQxW9BrMtl7rNeIyjWZhIiPSNXF53nuDigWFHFI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789218555; c=relaxed/simple;
	bh=YFCNLkNoSu9d7IZZogCYE49Ts58xA3j39fphN8xkoHM=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=btlSPPYnjxUVMLKnwb2yaQoqrXUaOtGwSE6X5nJhEzVl5iyED14FzYPv+Up9R3oT1SXyNgcWIAe/wcIAMRMK7JLYSgShRwv6CaLVdSJ/megGzEHuFo3IgBUjGMihMyX82TtMl1axwqx9VcGjr/0nNpi4sVlEHz+MxbCL3vRGNcU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.co.uk; spf=pass smtp.mailfrom=hotmail.co.uk; dkim=pass (2048-bit key) header.d=HOTMAIL.CO.UK header.i=@HOTMAIL.CO.UK header.b=TJEx6J0w; arc=fail smtp.client-ip=52.103.33.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=HOTMAIL.CO.UK header.i=@HOTMAIL.CO.UK header.b="TJEx6J0w"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w/f0Bluulev8CMEszLSBOmvo28S1NROhEXIAuZWG8B1qJulvkEfnSKkWm/rijfoj+yoOpRLPd8CmDZtueExAcp8Dq0dVjIbBvhOVo5iHFR67BgcjlgBcN+JZj+0BpYK78lc8HxSSlXyE7Q/KyONG7EU3tIkOt+RAjCHBv7OIYXSefiQsHQqCkmEFKLsuFa5xaGjpNwrujniqZ0WmA+599FFuM06B/BYpvn03ZpHvkqD20igWrCXfdKnCZ1aYs/ETiK1qRX5hUmsNim3pT41iVo8+wCBXyQLMc6TH4sAEMiTHmUmw2QN4cRGbI8ZEFjZaT1EQjS5GpWNqMt1bfh3rPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6prBQcJv//Uq3BliPhDut2Bmj7/AmZ6B8oo5icAuUOc=;
 b=gs3WrWYI4ezPoUi08VaKK35B08HIAtw6gUWOveVgxktet0o6IsSjubZ2Kx0t4L2pRJaIcULbkdgAcOXKoxvJiAtTByWLCGLzQXWcMxhqljIh3lh/7pUTH7714xtmXSMYdhu8q7yuvAmche/YVeLir4yzI7UdD49Ma0LLDivp7SPONOrjFjfjOx4/k3kxtCqy38rYjGlauu+GlTZxq7scext5aPg/8J3vh+FMmJ0sv87Of66bFXoQIsXY5KuzY48vhGdWppEN/azndlbD/apiOXYMt3EmKSkCdBVO0MvpdidL41rWR2bSQvLyI75eYl5olBsC0e1yHSkyOx/bhQ+RBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=HOTMAIL.CO.UK;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6prBQcJv//Uq3BliPhDut2Bmj7/AmZ6B8oo5icAuUOc=;
 b=TJEx6J0wm78Lz/qE+dNexF/Xr3fhA14wOwGHDbpbhnRuZGX6at87S75MuarMCjojR7wdjVBbbSon13JMybqz6twKGC5uiYXcVq/RkzO/w4+f1CfG0XkAm6Y/gVNJ099IWroGDgcW4vluxymvE6RvIDRvQ8DTf36DMssb2Axt894keUmiK5XCGXWFBNfPkM2s+2XPmhmhnQsVIrZAe621pUFTj/fTc5b8Mh+B0DRRy3XIMxK8+gARyBn+46bpyPQxgjUWCSy+29VEPOIRmgSouylMl/5IURY87t7s1AORL05wAimFRvFtyC+fxXim7uDWB49CqhOPU0MVb1BB77nDJg==
Received: from AS8P251MB0001.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:344::22)
 by GV2PPFDCA549DEA.EURP251.PROD.OUTLOOK.COM (2603:10a6:158:401::b6c) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.10; Sat, 12 Sep
 2026 13:09:08 +0000
Received: from AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 ([fe80::2952:d4d0:4ba:8352]) by AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 ([fe80::2952:d4d0:4ba:8352%3]) with mapi id 15.21.0406.007; Sat, 12 Sep 2026
 13:09:07 +0000
From: Aamir Ahmed <elb12345@hotmail.co.uk>
To: Bjorn Andersson <andersson@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>
Cc: Luo Jie <jie.luo@oss.qualcomm.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	gustavoars@kernel.org,
	Abel Vesa <abel.vesa@oss.qualcomm.com>,
	Kees Cook <kees@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] clk: qcom: ipq-cmn-pll: Assign .num before accessing .hws
Date: Sat, 12 Sep 2026 14:09:06 +0100
Message-ID:
 <AS8P251MB000187BDFAD98A21F4C356E9C8BD2@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0188.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a4::13) To AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:344::22)
X-Microsoft-Original-Message-ID:
 <20260912130906.12496-1-elb12345@hotmail.co.uk>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P251MB0001:EE_|GV2PPFDCA549DEA:EE_
X-MS-Office365-Filtering-Correlation-Id: 531d2d49-7680-4986-9251-08df10cf0725
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|41001999006|24021099003|55001999006|25031999004|37011999003|51005399006|8060799015|19110799012|23021999003|5072599009|5062599005|15080799012|25010399006|40105399003|1602099012|10035399007|2607281247196008|3412199025|4302099013|440099028|26104999009|19061999003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?99WioDlHBhLGB1LI1wDUWwfVnLLXpq+wJvJngSBWkzBsIQXlGwLjvAJryvzI?=
 =?us-ascii?Q?upDMrEXRPSTyHr8lFl7VOILVWlmR+iBKPdX9NNStTk5k3+jYwAu5kSC9AKh0?=
 =?us-ascii?Q?/6IvTfEtneOBFsJRotZdbcqhTWBATyLLRkd0sAI3jhY452HeRqXG5ZUaCcAt?=
 =?us-ascii?Q?3t9N+sz1MPwv6Wm6E4hJMNnswzCc8IPPzcvRHQNnjb6uEreuwT2YAGhizomA?=
 =?us-ascii?Q?U4t0c4661ThT6Ay617+5AvyKM7FqaIK9q7KPdHTtd6qrrcGJPGktrsfHGiXI?=
 =?us-ascii?Q?F0plmsFvqYNuwyxZRN0iTicHzSQ2aHQ4advKoGxb5VVgUyA66Jz65G3mCViW?=
 =?us-ascii?Q?KaHpSmOlvqFz9VtFT8zAWMHZsXXY5VdEVXIhVK8KZHxeF+GFQvZLlLlN08Zu?=
 =?us-ascii?Q?ZEMVZ+B0tX9WSAoVwgPVowos7efujmpUMbIxdAk91C/U7kyN+alvDugJdEhG?=
 =?us-ascii?Q?ZV9sDTPpAgTPW2HsPmCOGKHyJ2NiniXGTjMMSSXM2cqcAk2HJRwhybf1pd4x?=
 =?us-ascii?Q?sSIUf+vso3RF75SGfU8L7exc+S2BCbnlX2SzGZxneDiMf4Etw+FsHv7YQLEA?=
 =?us-ascii?Q?qhDovMwLLGRVECKXNv+CdK4ppjRmVST3C4A1whok1CBkvsmXm8HpFbyCUTQK?=
 =?us-ascii?Q?Vf5FYRNzmAthZLIkrUyJL/KPTIY0HNOSyIcLJvMy96E8muArL/ZFjSKRGc7z?=
 =?us-ascii?Q?5pDvwS0gPXX9O0S7iEUdgDcTpxpdNhtatXZl1ga8bWCjgtP/EV6pPh0FfQEn?=
 =?us-ascii?Q?N2gFAHkX1UR4gOD3rBEvFh1LPqsGW0ZoKZAt6+lfz4iM9vt4iYeS9V2HQCRR?=
 =?us-ascii?Q?EdzpzwKMQaW5kSpQHulvEoiWfS58OV1bgL6cQ4Ikx74FAm2tZbSJz1O0o8KN?=
 =?us-ascii?Q?dtvVt5rN7/AkpjRyl6Oh6TUPqGydLU+vg3+PeEeloApaCb1OqU2mc5FLf4Hr?=
 =?us-ascii?Q?iFtBVwOIyQURBpMNWyGqVNIPEftJpUxXCZZxgdpnmY2tFQjU9D1lepLYhZYx?=
 =?us-ascii?Q?0+mk0iY3EuZU0xWIOlVIzjCLu7RrM9ytp61T1Z4NhudUv5/1bAHZcHQpE3oI?=
 =?us-ascii?Q?qS78j4FzlAiGZ9c231l2nD6/AfA0hYBhEiQ0cRfwYVmWyossezp32B3pmLDi?=
 =?us-ascii?Q?dtNAvPZ6r1+OWy3cQwmn8Jg2TIcSdXwGqGr1B53UDKXsqNRd3DOmtMVvd32F?=
 =?us-ascii?Q?Snq1bwkXeYNbQQWBirfLJ7yXELrltLdOEx5fUJSPOvuCRByeDKMTYzlV+sw?=
 =?us-ascii?Q?=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PWT4FXarE3PT+81oC70yv/AA19bHEmehjtE9DP/HKFgotTF2p/HsffbB8G7y?=
 =?us-ascii?Q?NxDX5dQYwMMRPr7Go1FLri4f0u7924CEa8+r5i4or0/6OP763OxUNXSVShYu?=
 =?us-ascii?Q?QShZYxRBc9hCBGD8FYtTqPuVKNCGDSwcB9R5OKrIMNBN+g+naAH7jxcruQIi?=
 =?us-ascii?Q?8bJ0pFF3pnUObifFAlhg3ca+H+C9XWuvyOssa4QwpdG9NTCA/0yxyz9iCDKq?=
 =?us-ascii?Q?DEC+k2x4VpQ2ustfFiON16XP/8hsjxTubMP8VogieLzXJlEY33plFHSUmGHS?=
 =?us-ascii?Q?VIoy/vMKlAqPgcmWAiGIaeAtX9H5tbgYiHypq8/hcYi+7EPU3nHFQBEYxEzk?=
 =?us-ascii?Q?6A+jmfPYQajeEbnliTPNRVzIsu3gWhrDFPy8BXI4xm8zVXYX/rY4XFOij0wx?=
 =?us-ascii?Q?RHTh3kcInH++9GGnH5pD3e0Bc/xO9IZOhHRIcxUIvcHqYHciHstCOiTIbZe6?=
 =?us-ascii?Q?t8FnAsYdH6mc4HnMSjVKYB/U7V6yvLTR24CHoEoBwKja7nulC7P5b+4aFsCi?=
 =?us-ascii?Q?6FmSIF80I82FT8QraAql9oDjDSzPSwE54ADsw5fz4gvP86xtWX4s9N3Ftasn?=
 =?us-ascii?Q?q3Ylu9XPWhHoa6cj+b+xratJfZwLtKY0iBk1ntOgPMy4pC2CBgJuayURPk/3?=
 =?us-ascii?Q?m9AY6pOp3bzoZmaz0NCAyDuqu90H4AxQtkmVV61udR6+afR4NJ8vRQbCYLAT?=
 =?us-ascii?Q?B+f1KqnZO10GY5Z9PogkaKuDXr8RJm3smcaJtSJoLvSZrbN6R2M5MusFqak/?=
 =?us-ascii?Q?rlL8cGalykWZqlv+ZiTBNWvpGcErVzd57vWBiXofVYWD0zFOqvnupWvF6o4Q?=
 =?us-ascii?Q?/Y2ta6nOG0ECQsQZxmhe6kpumAhgC1GgOtmtWpBw9f8mdEbxvw2Qo6eukZP+?=
 =?us-ascii?Q?RAM3WZNozK1nnfTYznqdKyre/hh8wHY+EEEPSwdFHt6+ZjZokysfursaqVNi?=
 =?us-ascii?Q?WuFo8BchlLKL4mzOdxXjBpeLP/eHSwJhTbDDtLMdgDSVcTZI44X/JxMI7rrF?=
 =?us-ascii?Q?M/hRrijVEvdgM4TvnlxReMwQM0p3jsw3B8ed9AfUD0yVJtHWk3IHCyBAA9sT?=
 =?us-ascii?Q?TEncFq4N9yDFadOjDPNsuzwgOXOb9lOSNTH2Y082FqWr4RgTzx+THK0mZQZn?=
 =?us-ascii?Q?cAfNu/Z3q3Z72ofN07x5LS3YROis4Wo5FEXAOQXbzNdaQEDxEViNK50SF/9J?=
 =?us-ascii?Q?9YFSfWGcKSB3E94aRfEG6zWT6LlSTj5twbmOw6cvBHweuPoTAn+cAv+6KFc2?=
 =?us-ascii?Q?nAq+Sxn6ojjFFI0+SJv49IAzwdfFbL1V7u0VBH38p9++YVoRWfpoP6b2zNxx?=
 =?us-ascii?Q?w2rOwyZZsDeedcXYW5K6S8igJXFGihgk+g7zq6iVn5P5JO/MPdhhZfm2Yqhj?=
 =?us-ascii?Q?SLiC6Hl+xVA1HayHwss0RSfniWRIgGqBrAqwSx/ZaGu+55hEVWWEzS/uZx6K?=
 =?us-ascii?Q?SbTPU0MOYmV/T/yL8IsixHij10VWeWg4?=
X-OriginatorOrg: sct-15-20-9412-3-msonline-outlook-fe3f5.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 531d2d49-7680-4986-9251-08df10cf0725
X-MS-Exchange-CrossTenant-AuthSource: AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2026 13:09:07.7077
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PPFDCA549DEA

hw_data->hws[] is annotated with __counted_by(num), so hw_data->num
must hold the element count before the array is accessed.
ipq_cmn_pll_register_clks() assigns it only after storing the fixed
rate output clocks and the CMN PLL, and the unwind loop under
unregister_fixed_clk reads .hws[] with .num still zero. Both are
out-of-bounds accesses under CONFIG_UBSAN_BOUNDS.

Move the assignment to right after the allocation.

Fixes: f81715a4c87c ("clk: qcom: Add CMN PLL clock controller driver for IPQ SoC")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Aamir Ahmed <elb12345@hotmail.co.uk>
Reviewed-by: Luo Jie <jie.luo@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
---
v2:
  - cut the commit message down (Bjorn)
  - collect Reviewed-by tags
v1: https://lore.kernel.org/linux-clk/AS8P251MB0001B905088748016A0965F1C8B42@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM/

Compile-tested only; I have no IPQ hardware.

 drivers/clk/qcom/ipq-cmn-pll.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/ipq-cmn-pll.c b/drivers/clk/qcom/ipq-cmn-pll.c
index dafe8c1738df..a9abad9ff4e5 100644
--- a/drivers/clk/qcom/ipq-cmn-pll.c
+++ b/drivers/clk/qcom/ipq-cmn-pll.c
@@ -380,6 +380,8 @@ static int ipq_cmn_pll_register_clks(struct platform_device *pdev)
 	if (!hw_data)
 		return -ENOMEM;
 
+	hw_data->num = num_clks + 1;
+
 	/*
 	 * Register the CMN PLL clock, which is the parent clock of
 	 * the fixed rate output clocks.
@@ -406,7 +408,6 @@ static int ipq_cmn_pll_register_clks(struct platform_device *pdev)
 	 * is configured to 12 GHZ by DT property assigned-clock-rates-u64.
 	 */
 	hw_data->hws[CMN_PLL_CLK] = cmn_pll_hw;
-	hw_data->num = num_clks + 1;
 
 	ret = devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get, hw_data);
 	if (ret)

base-commit: df2908090cda368b01ff43709f51890076c56157
-- 
2.55.0

