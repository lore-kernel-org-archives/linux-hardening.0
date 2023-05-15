Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9417EC77B75
	for <linux-hardening@archiver.kernel.org>; Mon, 15 May 2023 19:58:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242991AbjEOT67 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 15 May 2023 15:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234077AbjEOT65 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 15 May 2023 15:58:57 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9921A658D
        for <linux-hardening@vger.kernel.org>; Mon, 15 May 2023 12:58:56 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34FJrwRl003047;
        Mon, 15 May 2023 19:58:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=XPPsEOmf71zsHAnPsD5vSOfxzw6gEUOQAyuN8s0R3w8=;
 b=Zs/xXvaw3cl0jc06S2CoJ3aBcErnmzyzROWXWnMEZ2z0jonnb7Yv1ot2N3s20HJj0eD+
 3ZG9f542uDft2XSqgXXj+M0mhZHC2fiNRie/wjMYY52reQXDUI+fH6OopBPEzLGeEBnl
 RR6RLsy+oksKaB+O4oxk8JhDI+/wre4f7LWTrV2QPo4j1KQlYJ/ACPmqBwVOXjxobY/k
 g2k4PVqruiuickY0pYWgQIcVrwK64jO54hBkmRnnZ/O88vujq+N4HZNnW8z8YNXxHW0m
 b71zhgyORsvF1V1zxtXQglXPdNOydusAg8aQwtWXmeyHclG7LuTbYJa3G8S9XmiZKdno 9A== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qj2kdh676-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 May 2023 19:58:40 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34FII9SV018055;
        Mon, 15 May 2023 19:58:39 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2105.outbound.protection.outlook.com [104.47.55.105])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qj103m67r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 May 2023 19:58:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZukbvCwTLgwpaVAFH/nbTyv+eUUBhhW3nu2NTOfALFkEYxOZ2VcPS9yF+dPGFhE7Gh6tlyEZ1DqNeThmJSFCt4UJim+FBPqZSyb9NzR88YHmN6AF4R8ewZs4N67phzu6GxSvUVIOMtXUNIBGjZyV7dPc7vr3iI3MzPAWrwDboq8nhvE4RCKn5GxBVIrf+IrcLPRl3PkIhAjj3xIwfkwdWr7FMAjDfKCr7CKlo6bu48opcY8TNlwXWITJOzsvgWr++X47++xu7c/XX4w9FWzNL1Gsfs7Epwh/TlaoX+W7DQ6D0hIxtYAQ15M0VzTP5nAvrjNguxtzyB/diAnHZSPD/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XPPsEOmf71zsHAnPsD5vSOfxzw6gEUOQAyuN8s0R3w8=;
 b=SgQa1/jd+EoTuX5zcKt0HhOR4DQ4qlQym+9DQ2cpq38SLMTJQnzBJepXh3HVkB0peezbH96JFjID4aG+OoIbsFyPhXg2ogZyp99nxcL77s0eYameulsg1hh2r6kPCDTZRMctsHQe8oN+C7NMEH88nwY4/ynYlpjO3vNvJFOFwW7ac7CmHTDq7KJJDTrH1QK5PYbqrvEtDdlqYfGaFsodtmnEMFNuA4IqkJQ95MDr9x78akcIqP2F+WEfm4vE1H3PTkfoQtYHYxgTfBS6VHbFlbBH5EDx+CQC9GHp6NZ9bOyBjR7Yvk23AObNV54BNUylpL+7zEyl6DWWWQWUU5a9Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XPPsEOmf71zsHAnPsD5vSOfxzw6gEUOQAyuN8s0R3w8=;
 b=QS1LqULBtKTRT1S3NhrRYGsNjtXmKQj+E5Jorm5kh2PMzSS0U4FPgLIEYMq0FyTDwTRV9n+2e7BuoB550XwIK0kgooxcR7F7MkVgFGhUEmx4sGQjiBL/Ii/LbRZ5w64V1TqD8ZQ3bI9bRoPKSMs2J7vw/LWpBpL8v1BIZGBfoxY=
Received: from CH2PR10MB4344.namprd10.prod.outlook.com (2603:10b6:610:af::19)
 by PH7PR10MB7720.namprd10.prod.outlook.com (2603:10b6:510:2fe::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Mon, 15 May
 2023 19:58:37 +0000
Received: from CH2PR10MB4344.namprd10.prod.outlook.com
 ([fe80::7aa1:df38:105a:21fa]) by CH2PR10MB4344.namprd10.prod.outlook.com
 ([fe80::7aa1:df38:105a:21fa%7]) with mapi id 15.20.6387.030; Mon, 15 May 2023
 19:58:37 +0000
From:   Qing Zhao <qing.zhao@oracle.com>
To:     Richard Biener <richard.guenther@gmail.com>,
        Joseph Myers <joseph@codesourcery.com>
CC:     Kees Cook <keescook@chromium.org>,
        Alejandro Colomar <alx.manpages@gmail.com>,
        GCC <gcc@gcc.gnu.org>, Alejandro Colomar <alx@nginx.com>,
        Andrew Clayton <a.clayton@nginx.com>,
        Andrew Clayton <andrew@digital-domain.net>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: Re: [wish] Flexible array members in unions
Thread-Topic: [wish] Flexible array members in unions
Thread-Index: AQHZhCLuf5m2WRG8LkCSJk7/seKYAK9VQycAgAAsSQCAAB2sAIAABWAAgACX0ACABZyxgA==
Date:   Mon, 15 May 2023 19:58:37 +0000
Message-ID: <447B1CEB-B525-4143-854E-9BD2069C9E16@oracle.com>
References: <ac2550e0-2f5c-3680-08e6-0c224d043036@gmail.com>
 <44940599-7b43-99f6-5b09-4f050d645c7b@gmail.com>
 <202305111158.C78642624@keescook>
 <74ee73d2-04e-ea8-9430-93929446e925@codesourcery.com>
 <202305111410.CFE0875F@keescook>
 <CAFiYyc1JRm6gm8aw2ZQmcycN3AF3hu5wjwGeUgDCN6gRN7UbbA@mail.gmail.com>
In-Reply-To: <CAFiYyc1JRm6gm8aw2ZQmcycN3AF3hu5wjwGeUgDCN6gRN7UbbA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.2)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR10MB4344:EE_|PH7PR10MB7720:EE_
x-ms-office365-filtering-correlation-id: 5fb1fa93-e333-47a9-d4ef-08db557ec5a3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Wji0y28SVkM0kfiZfJ/ZTfVkyOiAExTb/M4JkEI8Ozu4pG/JJ001tBqVevLzrqBtHJ7J2mn/RUNk5EHQFUg8mTqWNNrz34B0PaJZOIu8BhpOK66OzGQZN+QcAe/Y5IyY/L1lV4z6A28AuuUCkaJCCzS2+6HqMuhQWOgyWWv4FBRMkigQaKaKicMnkQmq0YBMo5Qy0EwWWZDOFnfgL1JwkbBYFBWuNnVCiCvvOpmByRD8uGVoEefz2DiYwM9v/s04D1YKyvTDGtqSV3tph6YC/XLWLpdEqX7QPrajiwt7DN0HVl/YG9MITVSQjf790GjJNZCmFKHEx9ysWDwOipfHOOJW8/nyOUfWaTq3A8kmib/RyxSY4rcGOjAggEQ2jlG8DzH57vDAdAInspYQxCXdw+wgR8oPE7BvYFmWf6wTKZGjmM949BuKM7J06QCSRiYQ5irH0EofbTLwGYofY5DQLFLfnEGTAlMzpgp4f4Npkpvc515BUuaNPBHwEDIWq9NjjujtH/2yWdnYxptIaW1Jy7GZw2t2BYcbSkCSe7ti0KP8urcCNE8/udHZ9mL4duDlFdvdHXnweCftZv6gYlIoSH9lEC3wfY3gNknZ3vG6Wota/HOpoWh7eb/NSvfivBd0PL8Jcym5MqrA5pPjY1Zn5g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4344.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(346002)(39860400002)(366004)(396003)(451199021)(64756008)(66946007)(66476007)(66556008)(478600001)(66446008)(4326008)(76116006)(6486002)(86362001)(91956017)(316002)(54906003)(110136005)(36756003)(33656002)(83380400001)(186003)(53546011)(2616005)(6512007)(6506007)(71200400001)(8936002)(5660300002)(8676002)(44832011)(2906002)(122000001)(41300700001)(38100700002)(38070700005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M0ZpcTBrVVRiTGk1ckdpKzlBdEVsUVhZZENhdktGNThrZUgxcUhuRXBvWklX?=
 =?utf-8?B?LzVaSG85VVgwcUVKNDNZR1VwUkJiSXk0WVZ5QWpkYWlZWktBL3J6MGtUc29r?=
 =?utf-8?B?MUYwcjRXcWR0Sy9MMlBCWVUvZ1dLTkdaNG40bWV4TXJxNlJhODdSdlhGRzd2?=
 =?utf-8?B?dkNsOGRSWVY2NmppT0FHNHI2Wit3ZXB5WGVCU2szUmkxOURXMDhSUFpwN2hM?=
 =?utf-8?B?MXFMTnZsZFg5L3hTQnF0YXBZK3JwR1FKcnhML0VZY053NWs0RjN3RHV2aDBo?=
 =?utf-8?B?Zml2ek5Yb1NtZmVLVXhqc0hXK1FONzErYVdVelkvV0I0WWlna3VBRmNCRzZ4?=
 =?utf-8?B?SDZ2NGEwK3U2Z2lmckI1VGtDTkYwaURkdnF5cUx2OTF1R3p1V1laaG5qekJF?=
 =?utf-8?B?ZVcxTk1uaGU2UndXcFdFR0NBNEpNYjlKY3FBU0h3ckhieHdtR2lLUUpQVC9w?=
 =?utf-8?B?Y3Z2VFh2b1QrY0lKeEFScld0T2xyNlhVRGVQaitFRXhOZE1wcDUxUFdibTU4?=
 =?utf-8?B?V0VlUmRxZEx3UWpGcldzaVNsWFlWaytNcGI4aEg4dUR6WFJrekxWSVJCL3gz?=
 =?utf-8?B?SkdNaEtTa1dsR1dlSHZrU2k1aGlZbHAyQ1pPYU5wY1laRlVyOFZpRTZyNk5X?=
 =?utf-8?B?cnFZQ2RJOTBucm9uK2YrQ3JJbHkxd2ZUeFBhaXpTekpTRUxKbFRiY0lGcGxD?=
 =?utf-8?B?Z2pGek1rakNIelU0SXNZWHNpQWsxWmREc1BhSFk0UzlhK1B5czZsRlB6c3R1?=
 =?utf-8?B?cnhMNGRzelBZQUZBM25sL1E4anAzc3Y3VFN5VFBlZDdURlVLSmhiMDU1N1Ir?=
 =?utf-8?B?bFNkSGJMN3hoVkVJbXQ4cGtOdVFjOTVUWXlVYWo2WHhrZWJXb2dtZWFkSmk3?=
 =?utf-8?B?b3RoMTRtejRadWpFb0JwcFROWVA1ZCtmZ0V6Z1ZQNExPeFlOTFRPRlJURGVm?=
 =?utf-8?B?RE0yZXIzTFgybTF3ZWdLUFphWUE3NmpIUG5xam1UWEdwenF3RU5WWWZMT2lk?=
 =?utf-8?B?NXZ1alU3eklRaVp4ejdwV3Y0THVWVTZKOFRQZDFzYmluV244K3dsWmVjczNP?=
 =?utf-8?B?emgrT3lBa1NvZkFpKy9Rd0w2c3VWMEZROWZMMDNTR1hTWExCU0haU2Rkd0xh?=
 =?utf-8?B?VW5XdDQ0T3gxRHFVWTlvaENmTjBDekVFdFZHVHlXNGxJbHhEc3ZDRkNKN0p1?=
 =?utf-8?B?Q3hOa0U0YWcxVm1WaGlwbFJWWm12Q2F1ZnlWZUZTUmh0OGo5OEdYQUNNR1cz?=
 =?utf-8?B?YVAvWXo3UXBoRytCTUxEaWV4V1hyZVJRdGJ5cGYwSWorV3VHMjR1bEpMODZH?=
 =?utf-8?B?MXlBSTV2ZmtJUGkvK254ZVpTT1hhM0ZhaXpXOUtyNTRzZWR5czg4ZER3dkxm?=
 =?utf-8?B?QmxJNDBDeTJpbmlBOFlDMnFUVzFxcWd2V0FjSmNKNS9xWFVWSStWQjJnZTVj?=
 =?utf-8?B?UHd5eTVqQWQ0aUE1aEZRU1VEUmtGVkhQYzB3L2dUU0VhckdNU3lGMUJJcTRW?=
 =?utf-8?B?OStVY3FYRzRrSFU5ckRJeURYNDVyMEZtQTExUU85YlZWYVEvL1VXeThZWlFx?=
 =?utf-8?B?STZjNUFma3BLZlg0OXhhTGduVnZMa0lOYVozT2JYZkNiMUJvazRZNmRkS2pE?=
 =?utf-8?B?TVVPbnorUVg4aEdJNmw1akl5SUc5SFdFU2llc0V5Ymd6NFhmUkxzOXp5ZDgx?=
 =?utf-8?B?Yk5HaERrenV3ajdSejVWMTVNdDM2aTZiUGFSQ1crUnRUZ2M0Kzc1dkt5VHcy?=
 =?utf-8?B?RkRlVktiVTI5ZmpPR3lGcHVPcEFrdTRuMitIbkFadVVHUkNGbGpDdnN6RTF2?=
 =?utf-8?B?TmE5ZmFPTzNSZU5kSzA3c0Y4QTluNHliOUhLVHRSWm1VbjdiY3pzT0dXd2Q1?=
 =?utf-8?B?S2FGUGNhTGZEWFBjdFBRbkVyK2Yvcm9VaE1kak9qNXNnQjRMdU9BRk9XWHlD?=
 =?utf-8?B?NkVybGF1SHVUVFZhTWdPaXVPRnVRUVFqVjRsU2FWczQ2MXp1bzBFZ3R1RVdL?=
 =?utf-8?B?S2dlKzUwREV4VDZPUHQyUkhmSlRyY0JPU1dScnlxNFNBTXdFRDlYR3NFWERx?=
 =?utf-8?B?WHREb2toUWJkQmFRekdDUHEzYitaWDZsaVJCQ1R6eklORExXUzhMUTVKWko0?=
 =?utf-8?B?UE9kUWpYZ2loK1V2bmw2M1JIRzl5MlVObFd0M3F2M09nM0xLYmFoZVFMa3dF?=
 =?utf-8?Q?1PUQC8M1qRKoFmua7LcyFhg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3062FB471B54B84CA0146F381A2C50B9@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?elVCQ3RKa3NXcENFcUU1U2ZReFJFUWtzVUhhUzF4ZXF2b2VkYzQyeWt2Q3lM?=
 =?utf-8?B?OWVaYnR1aGJ5ZTVZK3Q1WVZFVlF1Wmp0ZXowc3F3TFh6ejNMNUt4b1hyVHZO?=
 =?utf-8?B?Yk9HeEkwSWlZL1hncDkyTGtZTVVaMzdKZGxTMzhmL2doSDVFWUlrYlI4NFVi?=
 =?utf-8?B?dWpxQjRMb1dSRGwrK1FuZVNxclE5cEk4NFp5UnRtbUM3UFZOY0xESktWSFcz?=
 =?utf-8?B?b2hrd2VIVXRtaTVaWC8rTVIrZE5aVjhLY0pXUVA0UjJobDc2SWYrajY5QnlD?=
 =?utf-8?B?QUZrU1hDdytrYnhOUXVNbHY5K2EzT2NKd2JsdllzeWU1eVhhMEhXWGo2bDdM?=
 =?utf-8?B?alJELzlMN0RuV2F6TkdKdVhwMUVjWFY2MmhxQ2l0OTZVYkpTWXVNdnc4OGRy?=
 =?utf-8?B?bnhkQ01PL2NGcFpVVGlWZlorQVBrUE5TNUdzaWFKWmdmL2lOQkNuT1ByWUhx?=
 =?utf-8?B?M2VPMnlCN0F2WHNmclYwTHZUTUV2eU5ISjIzclFhUEl1RTNzOWFid3JwWVBN?=
 =?utf-8?B?eDl2azU3blI3RmpKUWZDRjFMRXk5Z1FQT0JTQ1hUZTg1MWNvejRjeDl4c0JK?=
 =?utf-8?B?TlNCamgwazBDZElMaGVlclRtMWE3V3RPRGM0NlhvaHNOSWQzMW4yVXVhNFpp?=
 =?utf-8?B?WU5MaHRZRWRzd096VHBycUhXK2dBK3lzVmRwREVmKzNFRll4Zzk3eVRYbUU5?=
 =?utf-8?B?bjBFY3c5dXUxTjErS0M1d3BwTEFHUGp5TDI1NjRwcitrcHhTN0xwSjhQM1pR?=
 =?utf-8?B?V2E3Zlh0bWVrYlJ5dW5nU1EvTlRmQ3psWjh3a0hNMjdSSjhrU1VHYjRYSEk4?=
 =?utf-8?B?M3RVU0hmcWkvbFp6QzkyaWMwQ1hkQWp6dzRiVjUyMEVOOEgvbUQ2OFI2OU9B?=
 =?utf-8?B?K0lkYXpncjFYdGlLSHN3S1VWWFc2ek9mZmw2ZnBIQVNuYnMwWXJ6bXdxVzRh?=
 =?utf-8?B?SXVqQTJGL2piazQ3empwVThYa0Q2bjliNXpBWFVDdG1qUTRwc0Y5L0RSMldz?=
 =?utf-8?B?bVJxbXpjQnVzVHRiL1l0OWFsa3AvSU9vc2wveEY0elhWZkY1ejVHSldWSEll?=
 =?utf-8?B?QklpdFpXQTlxQTBYK2MwcHNac0xGZDRZWlNsTnZvUTNvd1pFbTcvdS92VFBl?=
 =?utf-8?B?bkUrZnB6L2d1YmYxa0NHOTBoc0xzYTRoNUpreWZMNTlrN1ZuZGNXaU1OeHlM?=
 =?utf-8?B?REJxeDlOTmdXZkc5V3grMDM2NytuTFFDMXkyc1N4Zk5tUXpPVTcrcXRIZy9i?=
 =?utf-8?B?VzJrN2xIM29HNUdYeSs3eGdMVG0yd0hJREZPZ2xIZ3JSc05iVUpWZVZTTVQ0?=
 =?utf-8?Q?aEhcfCAYpDnEk=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4344.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fb1fa93-e333-47a9-d4ef-08db557ec5a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2023 19:58:37.2634
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dPkNCy486sGHSS3FiFC7T6Po8P5Bf4Rk/8n5jdwFDUi0G/q3V0zSaasEqDgyvObpgboo0CdsRb79Qpq06Ycf+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7720
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-15_18,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 spamscore=0
 bulkscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305150165
X-Proofpoint-GUID: bBcR0Js-0WsKqjjRzsdQ9mzASBOfHEgE
X-Proofpoint-ORIG-GUID: bBcR0Js-0WsKqjjRzsdQ9mzASBOfHEgE
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

DQoNCj4gT24gTWF5IDEyLCAyMDIzLCBhdCAyOjE2IEFNLCBSaWNoYXJkIEJpZW5lciB2aWEgR2Nj
IDxnY2NAZ2NjLmdudS5vcmc+IHdyb3RlOg0KPiANCj4gT24gVGh1LCBNYXkgMTEsIDIwMjMgYXQg
MTE6MTTigK9QTSBLZWVzIENvb2sgdmlhIEdjYyA8Z2NjQGdjYy5nbnUub3JnPiB3cm90ZToNCj4+
IA0KPj4gT24gVGh1LCBNYXkgMTEsIDIwMjMgYXQgMDg6NTM6NTJQTSArMDAwMCwgSm9zZXBoIE15
ZXJzIHdyb3RlOg0KPj4+IE9uIFRodSwgMTEgTWF5IDIwMjMsIEtlZXMgQ29vayB2aWEgR2NjIHdy
b3RlOg0KPj4+IA0KPj4+PiBPbiBUaHUsIE1heSAxMSwgMjAyMyBhdCAwNjoyOToxMFBNICswMjAw
LCBBbGVqYW5kcm8gQ29sb21hciB3cm90ZToNCj4+Pj4+IE9uIDUvMTEvMjMgMTg6MDcsIEFsZWph
bmRybyBDb2xvbWFyIHdyb3RlOg0KPj4+Pj4gWy4uLl0NCj4+Pj4+PiBXb3VsZCB5b3UgYWxsb3cg
ZmxleGlibGUgYXJyYXkgbWVtYmVycyBpbiB1bmlvbnM/ICBJcyB0aGVyZSBhbnkNCj4+Pj4+PiBz
dHJvbmcgcmVhc29uIHRvIGRpc2FsbG93IHRoZW0/DQo+Pj4+IA0KPj4+PiBZZXMgcGxlYXNlISEg
QW5kIGFsb25lIGluIGEgc3RydWN0LCB0b28uDQo+Pj4+IA0KPj4+PiBBRkFJQ1QsIHRoZXJlIGlz
IG5vIG1lY2hhbmljYWwvYXJjaGl0ZWN0dXJhbCByZWFzb24gdG8gZGlzYWxsb3cgdGhlbQ0KPj4+
PiAoZXNwZWNpYWxseSBzaW5jZSB0aGV5IF9jYW5fIGJlIGNvbnN0cnVjdGVkIHdpdGggc29tZSBm
YW5jeSB0cmlja3MsDQo+Pj4+IGFuZCB0aGV5IGJlaGF2ZSBhcyBleHBlY3RlZC4pIE15IHVuZGVy
c3RhbmRpbmcgaXMgdGhhdCBpdCdzIGRpc2FsbG93ZWQNCj4+Pj4gZHVlIHRvIGFuIG92ZXJseSBz
dHJpY3QgcmVhZGluZyBvZiB0aGUgdmVyeSB0ZXJzZSBsYW5ndWFnZSB0aGF0IGNyZWF0ZWQNCj4+
Pj4gZmxleGlibGUgYXJyYXlzIGluIEM5OS4NCj4+PiANCj4+PiBTdGFuZGFyZCBDIGhhcyBubyBz
dWNoIHRoaW5nIGFzIGEgemVyby1zaXplIG9iamVjdCBvciB0eXBlLCB3aGljaCB3b3VsZA0KPj4+
IGxlYWQgdG8gcHJvYmxlbXMgd2l0aCBhIHN0cnVjdCBvciB1bmlvbiB0aGF0IG9ubHkgY29udGFp
bnMgYSBmbGV4aWJsZQ0KPj4+IGFycmF5IG1lbWJlciB0aGVyZS4NCj4+IA0KPj4gQWgtaGEsIG9r
YXkuIFRoYXQgcm9vdCBjYXVzZSBtYWtlcyBzZW5zZSBub3cuDQo+IA0KPiBIbW0uIGJ1dCB0aGVu
IHRoZSB3b3JrYXJvdW5kDQo+IA0KPiBzdHJ1Y3QgWCB7DQo+ICBpbnQgbjsNCj4gIHVuaW9uIHUg
ew0KPiAgICAgIGNoYXIgYXRfbGVhc3Rfc2l6ZV9vbmU7DQo+ICAgICAgaW50IGlhcnJbXTsNCj4g
ICAgICBzaG9ydCBzYXJyW107DQo+ICB9Ow0KPiB9Ow0KPiANCj4gZG9lc24ndCB3b3JrIGVpdGhl
ci4gIFdlIGNvdWxkIG1ha2UgdGhhdCBhIEdOVSBleHRlbnNpb24gd2l0aG91dA0KPiBhZHZlcnNl
IGVmZmVjdHM/DQoNCkkgdGhpbmsgdGhhdCB0aGlzIG1pZ2h0IGJlICBhIHZlcnkgbmljZSBleHRl
bnNpb24sIHdoaWNoIGFkZHJlc3NlcyB0aGUgc3RhbmRhcmQgQ+KAmXMgcmVzdHJpY3Rpb24gIG9u
IHRoZSB6ZXJvLXNpemUgb2JqZWN0LCBhbmQgYWxzbyBjYW4gcmVzb2x2ZSBrZXJuZWzigJlzIG5l
ZWQuIChBbmQgYWxzbyBvdGhlciB1c2Vyc+KAmXMgc2ltaWxhciBwcm9ncmFtbWluZyBuZWVkPykN
CkFuZCBtYXliZSBpdOKAmXMgYWxzbyBwb3NzaWJsZSB0byBhZGQgc3VjaCBleHRlbnNpb24gbGF0
ZXIgdG8gU3RhbmRhcmQgQz8NCg0KU2ltaWxhciBhcyBmbGV4aWJsZSBhcnJheSBtZW1iZXIgaW4g
U3RhbmRhcmQgQywgd2Ugc2hvdWxkIGxpbWl0IHN1Y2ggdW5pb24gYXMgdGhlIGxhc3QgZmllbGQg
b2YgYW5vdGhlciBzdHJ1Y3R1cmUuICAoU2luY2UgYmFzaWNhbGx5IHRoaXMgdW5pb24gY2FuIGJl
IHRyZWF0ZWQNCkFzIGEgZmxleGlibGUgYXJyYXkgbWVtYmVyKQ0KDQpRaW5nDQoNCj4gDQo+IFJp
Y2hhcmQuDQo+IA0KPj4gV2h5IGFyZSB6ZXJvLXNpemVkIG9iamVjdHMgbWlzc2luZyBpbiBTdGFu
ZGFyZCBDPyBPciwgcGVyaGFwcywgdGhlIGJldHRlcg0KPj4gcXVlc3Rpb24gaXM6IHdoYXQncyBu
ZWVkZWQgdG8gc3VwcG9ydCB0aGUgaWRlYSBvZiBhIHplcm8tc2l6ZWQgb2JqZWN0Pw0KPj4gDQo+
PiAtLQ0KPj4gS2VlcyBDb29rDQoNCg==
