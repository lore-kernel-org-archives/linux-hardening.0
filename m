Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2052.outbound.protection.outlook.com [40.107.93.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CDDC1F61C;
	Thu,  4 Sep 2025 06:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756966146; cv=fail; b=S4UdigY1SSzkTOPX51LVHmvDHTYoS52rP1voa1OjAZwWSLmtgYWro09AwJQpQPClzylcC5Oh0epa0/YObaPcD58eioUNI18kj0uRSkkJHkKxYz/IiJABC/yGywf9recc2OvWOtgbNEUKMYc/BHH6AUbN9AhPyT+n45fAVvcTZt8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756966146; c=relaxed/simple;
	bh=waOMZGNhwJ+zPdNR12cEI/g6HtMcY7PN8VEAs0rN8lA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NrNRKGkCZgmaIBJs6FFStTaJHubLxp59usmJXGiTEoumN9utLX/ay33IliTvbviRuNBivvsqeuxqkbyfzzBTpkIuQHA8Q6uMt08jyD63snngETZ6cmhtw/UBfd3awVBCEZ5mH2wU1fqAe175dTbmyi/56gfProEyIYYZNmyMCnI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QhGgSPfq; arc=fail smtp.client-ip=40.107.93.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QhGgSPfq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QYRqmjfMLVPB0D1Dr67DQxpSxg62+wJ6Hd9n1HTwHNxb43ELBI3gP7i0fi6Odk/n94moWoO8VSqDk8gwiCQM8PWZM3IHpFS+267UnkdKnKp6jU+YjAv9Xi2oY4ro5b7Qj0eMyoC/ag03/5WlCg6vkIznS9AsRSEOXO9Y6E8JPhMKv7BReWRh675LIZgZPmWaHZgO3cwrOYOQuXfxAAJl+qn5vpeVQfSjeDGDTLyqaP9mMka8n2gmW1JRUCixLxTJjFT1gvPODMpcSyMtQLxKgChoZnY9wpfKpL65OBB70TVuEuWLEe3x4hWHCko28D4JZDY436vnrP/nlUAFmhagNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iskF6pw/BaLwhyQhuDxGd32BUtC72W31ollMVm4dUY4=;
 b=qk0LjcdTRuaQSpHV3YKwzmmMtCvPp2NB7M2i6Xv5ZdgTA8B4ZDmke8gfnEHDpqwpeWyv88IAV0pej8yl/J7Af/Hqm9LpxnE+YtFFGe25+fwYVqZS6vHnArwuPjfvTdo2q0AMO4Hmf2brjDvey43CmkK4LOUlBWqElALw4PfJAGLMklvoL1Pz1MUtR9L1nLAW0efmeA3L/ZS/iSFtKzRc2e/+h8fk4UT0G8cn1+FC2G+jw6KdRSUCyppEjwXbWJvwPCMnj9A1PuDektj4vymrORuQItBxPdHkvibfbXeUItdtG1pF1YT7kh2VbnAS5DGCzXVnIX7q1EPD2MZs1X/z+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iskF6pw/BaLwhyQhuDxGd32BUtC72W31ollMVm4dUY4=;
 b=QhGgSPfqvcDpCC+rrsxNaHNYysYcVaiXilYBFW/kDAKNqClofNR0cKCydCKPK4mtV2mALLxslMfFXIlcsmRnzCmL+BucIR/9RkOoetW3tp+5/WNfcHQe8oyDgV6PEU1kbIJZfbLukp/fNYQHR5x99A+o3oiKNlz7H/R9ckRRUqA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Thu, 4 Sep
 2025 06:08:58 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.9073.026; Thu, 4 Sep 2025
 06:08:52 +0000
Message-ID: <c0859f5e-18fc-4981-9af4-6bfb2716e06d@amd.com>
Date: Thu, 4 Sep 2025 08:08:45 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 1/2] dt-bindings: i3c: Add AMD I3C master controller
 support
To: Rob Herring <robh@kernel.org>,
 Manikanta Guntupalli <manikanta.guntupalli@amd.com>
Cc: git@amd.com, alexandre.belloni@bootlin.com, Frank.Li@nxp.com,
 krzk+dt@kernel.org, conor+dt@kernel.org, kees@kernel.org,
 gustavoars@kernel.org, jarkko.nikula@linux.intel.com,
 linux-i3c@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
 radhey.shyam.pandey@amd.com, srinivas.goud@amd.com,
 shubhrajyoti.datta@amd.com, manion05gk@gmail.com
References: <20250903095906.3260804-1-manikanta.guntupalli@amd.com>
 <20250903095906.3260804-2-manikanta.guntupalli@amd.com>
 <20250903204738.GA2744698-robh@kernel.org>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 xsFNBFFuvDEBEAC9Amu3nk79+J+4xBOuM5XmDmljuukOc6mKB5bBYOa4SrWJZTjeGRf52VMc
 howHe8Y9nSbG92obZMqsdt+d/hmRu3fgwRYiiU97YJjUkCN5paHXyBb+3IdrLNGt8I7C9RMy
 svSoH4WcApYNqvB3rcMtJIna+HUhx8xOk+XCfyKJDnrSuKgx0Svj446qgM5fe7RyFOlGX/wF
 Ae63Hs0RkFo3I/+hLLJP6kwPnOEo3lkvzm3FMMy0D9VxT9e6Y3afe1UTQuhkg8PbABxhowzj
 SEnl0ICoqpBqqROV/w1fOlPrm4WSNlZJunYV4gTEustZf8j9FWncn3QzRhnQOSuzTPFbsbH5
 WVxwDvgHLRTmBuMw1sqvCc7CofjsD1XM9bP3HOBwCxKaTyOxbPJh3D4AdD1u+cF/lj9Fj255
 Es9aATHPvoDQmOzyyRNTQzupN8UtZ+/tB4mhgxWzorpbdItaSXWgdDPDtssJIC+d5+hskys8
 B3jbv86lyM+4jh2URpnL1gqOPwnaf1zm/7sqoN3r64cml94q68jfY4lNTwjA/SnaS1DE9XXa
 XQlkhHgjSLyRjjsMsz+2A4otRLrBbumEUtSMlPfhTi8xUsj9ZfPIUz3fji8vmxZG/Da6jx/c
 a0UQdFFCL4Ay/EMSoGbQouzhC69OQLWNH3rMQbBvrRbiMJbEZwARAQABzSlNaWNoYWwgU2lt
 ZWsgKEFNRCkgPG1pY2hhbC5zaW1la0BhbWQuY29tPsLBlAQTAQgAPgIbAwULCQgHAgYVCgkI
 CwIEFgIDAQIeAQIXgBYhBGc1DJv1zO6bU2Q1ajd8fyH+PR+RBQJn8lwDBQkaRgbLAAoJEDd8
 fyH+PR+RCNAP/iHkKbpP0XXfgfWqf8yyrFHjGPJSknERzxw0glxPztfC3UqeusQ0CPnbI85n
 uQdm5/zRgWr7wi8H2UMqFlfMW8/NH5Da7GOPc26NMTPA2ZG5S2SG2SGZj1Smq8mL4iueePiN
 x1qfWhVm7TfkDHUEmMAYq70sjFcvygyqHUCumpw36CMQSMyrxyEkbYm1NKORlnySAFHy2pOx
 nmXKSaL1yfof3JJLwNwtaBj76GKQILnlYx9QNnt6adCtrZLIhB3HGh4IRJyuiiM0aZi1G8ei
 2ILx2n2LxUw7X6aAD0sYHtNKUCQMCBGQHzJLDYjEyy0kfYoLXV2P6K+7WYnRP+uV8g77Gl9a
 IuGvxgEUITjMakX3e8RjyZ5jmc5ZAsegfJ669oZJOzQouw/W9Qneb820rhA2CKK8BnmlkHP+
 WB5yDks3gSHE/GlOWqRkVZ05sUjVmq/tZ1JEdOapWQovRQsueDjxXcMjgNo5e8ttCyMo44u1
 pKXRJpR5l7/hBYWeMlcKvLwByep+FOGtKsv0xadMKr1M6wPZXkV83jMKxxRE9HlqWJLLUE1Q
 0pDvn1EvlpDj9eED73iMBsrHu9cIk8aweTEbQ4bcKRGfGkXrCwle6xRiKSjXCdzWpOglNhjq
 1g8Ak+G+ZR6r7QarL01BkdE2/WUOLHdGHB1hJxARbP2E3l46zsFNBFFuvDEBEACXqiX5h4IA
 03fJOwh+82aQWeHVAEDpjDzK5hSSJZDE55KP8br1FZrgrjvQ9Ma7thSu1mbr+ydeIqoO1/iM
 fZA+DDPpvo6kscjep11bNhVa0JpHhwnMfHNTSHDMq9OXL9ZZpku/+OXtapISzIH336p4ZUUB
 5asad8Ux70g4gmI92eLWBzFFdlyR4g1Vis511Nn481lsDO9LZhKyWelbif7FKKv4p3FRPSbB
 vEgh71V3NDCPlJJoiHiYaS8IN3uasV/S1+cxVbwz2WcUEZCpeHcY2qsQAEqp4GM7PF2G6gtz
 IOBUMk7fjku1mzlx4zP7uj87LGJTOAxQUJ1HHlx3Li+xu2oF9Vv101/fsCmptAAUMo7KiJgP
 Lu8TsP1migoOoSbGUMR0jQpUcKF2L2jaNVS6updvNjbRmFojK2y6A/Bc6WAKhtdv8/e0/Zby
 iVA7/EN5phZ1GugMJxOLHJ1eqw7DQ5CHcSQ5bOx0Yjmhg4PT6pbW3mB1w+ClAnxhAbyMsfBn
 XxvvcjWIPnBVlB2Z0YH/gizMDdM0Sa/HIz+q7JR7XkGL4MYeAM15m6O7hkCJcoFV7LMzkNKk
 OiCZ3E0JYDsMXvmh3S4EVWAG+buA+9beElCmXDcXPI4PinMPqpwmLNcEhPVMQfvAYRqQp2fg
 1vTEyK58Ms+0a9L1k5MvvbFg9QARAQABwsF8BBgBCAAmAhsMFiEEZzUMm/XM7ptTZDVqN3x/
 If49H5EFAmfyXCkFCRpGBvgACgkQN3x/If49H5GY5xAAoKWHRO/OlI7eMA8VaUgFInmphBAj
 fAgQbW6Zxl9ULaCcNSoJc2D0zYWXftDOJeXyVk5Gb8cMbLA1tIMSM/BgSAnT7As2KfcZDTXQ
 DJSZYWgYKc/YywLgUlpv4slFv5tjmoUvHK9w2DuFLW254pnUuhrdyTEaknEM+qOmPscWOs0R
 dR6mMTN0vBjnLUeYdy0xbaoefjT+tWBybXkVwLDd3d/+mOa9ZiAB7ynuVWu2ow/uGJx0hnRI
 LGfLsiPu47YQrQXu79r7RtVeAYwRh3ul7wx5LABWI6n31oEHxDH+1czVjKsiozRstEaUxuDZ
 jWRHq+AEIq79BTTopj2dnW+sZAsnVpQmc+nod6xR907pzt/HZL0WoWwRVkbg7hqtzKOBoju3
 hftqVr0nx77oBZD6mSJsxM/QuJoaXaTX/a/QiB4Nwrja2jlM0lMUA/bGeM1tQwS7rJLaT3cT
 RBGSlJgyWtR8IQvX3rqHd6QrFi1poQ1/wpLummWO0adWes2U6I3GtD9vxO/cazWrWBDoQ8Da
 otYa9+7v0j0WOBTJaj16LFxdSRq/jZ1y/EIHs3Ysd85mUWXOB8xZ6h+WEMzqAvOt02oWJVbr
 ZLqxG/3ScDXZEUJ6EDJVoLAK50zMk87ece2+4GWGOKfFsiDfh7fnEMXQcykxuowBYUD0tMd2
 mpwx1d8=
In-Reply-To: <20250903204738.GA2744698-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0113.eurprd06.prod.outlook.com
 (2603:10a6:803:8c::42) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|SA0PR12MB7091:EE_
X-MS-Office365-Filtering-Correlation-Id: 35bb8767-2f43-41c0-de6d-08ddeb798571
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aDZ4NXhKS0JSV0c2OHdrZHRMVjZCNEtrdVVDRk9SUUZOQ055OHVOcWxRU3g5?=
 =?utf-8?B?UnozYmNHSHprMkFiYjYreHhZWmpPSkh1a1BqQThmTk5idVozNXF6VFVMVjlq?=
 =?utf-8?B?bGlTQkY3RHhxTHpOdFUxZ3RtM1B5RmhPbmhqQzRES3pNa2V6dnNabXF3Rnl0?=
 =?utf-8?B?b1NCdWRKaWhrRjlMbU1QUXRhRFRxT1FwSkVrU1Q0QmJiSFdsR0FnUkRsVENj?=
 =?utf-8?B?V0MvT1QrZnFyejNydkl3eVZDOXUrdG9uS0RBKzFyZ0o4TTJSWW5Td0R1U3Vu?=
 =?utf-8?B?QkZUSyt5RHQwckNJcUF6ZHFrNGhsOExxRExyemNkd3lGejY0UmxXV1J1N2ho?=
 =?utf-8?B?OGk2Z3lSOUplUE9GN1lhWkpaSXEzbEZzWW5DblVhZEtHQWtJUGZrYXNYeTJw?=
 =?utf-8?B?NmI5UFhJZXRVYnBaQmFzTnp4aFRlbmtjRFFRYk82Wmp0c3Vxc2xmdFdvd1kr?=
 =?utf-8?B?a2lvOVgzRXhuWCtRdEMyS0VCWWVqYXk3amJPVmt4akYzUFk1VkRsVVlKLzVo?=
 =?utf-8?B?cE5DTFFRbHVXQ3VrZTluZGUyS04venEzOHlSM0NPek01eWNacExLOGEvejNw?=
 =?utf-8?B?ZWJZcWJZdnJyRm5ybXhZbFpVUTJpcTF5NFlEcjhXZDBCWWJiNml1Ri9vRDF1?=
 =?utf-8?B?SEg1VFZ6QUdpZ1BPRm92dFpYQ3NWZnpGSzlqMnhIVzBjUERYajVOd2R5UXRG?=
 =?utf-8?B?b0VWaTNnNGRiYTlvNWhSUDlyQ0dENG1UTGZveU92YkFaTW5mZlhuTlROMVNl?=
 =?utf-8?B?Zk1aY0d0UEtUcjZYcGJuVVg3NURoYWNIWkhOU3JIOHBwL1d4R3NsNktETjVy?=
 =?utf-8?B?NCtHQ3drYXJ4S0Fjc3BtcGJqVEptNXpNYTgvZjlKYWJSYUJ3OFF3eHpuR3pW?=
 =?utf-8?B?TEhib0RNdUowU25zYXUxY1gwNzh6NFZTV1dYYVRIcnhoNUY4S1p6YklqMzRP?=
 =?utf-8?B?NmRxb2N3UGVmVzVvb3p4Njd4b0Y4UU90UWVSaUNPczZOTm5nejJkMVNnQUc3?=
 =?utf-8?B?b2xoMUVyUkF1L1padzZ5Y2ZhYmM0bThpMExybURqYUV0NnF1UE16RFFkUFRF?=
 =?utf-8?B?ekJaTFhxTURaVUQ5QnhQdGxPeTU1UTF5Q1lUZXhzWlVXN0U3eHhOSThjYjlp?=
 =?utf-8?B?L28yV09uMFAvQmtvNEhMWHF3VU5QeXNsc2RLWWo2OGRvc0NJeTFqazhFTFpP?=
 =?utf-8?B?STBiYUpIMWZybkdoMVg0ODhiMzNwcG5PSVRqbm5WTXlidHBGaVlLSlBnM3By?=
 =?utf-8?B?L2srRlRTKzFvRjJVbHdtNXFJblZlemZJNFJmcVRId1kxMFAzMGE5VWMzWXlw?=
 =?utf-8?B?NmFFbXlhSU83eDFYcGZiaFp6aEg2eE82VW5ybWNMRHkxZ3I4cXNuVGRVMFlQ?=
 =?utf-8?B?eCtPRkFncnMxR3BGVDh0Z0trem9RQkRWRU5IWXZTSEtnTWptUXg1dzRnMzJz?=
 =?utf-8?B?aDJUeWxVMmZ5a0w3eG1EdWNjU0JEdFJNUzJHa3NwMU9keVE1SWtQRWJ4bWJr?=
 =?utf-8?B?Vlg2NlZaVEtJMTl3MnkyTVI4d1JXLzl2alBQbFpyUXNtb1hhek1BTithQUJi?=
 =?utf-8?B?bVRaa3dDaDMyZGR5cHMwdEhWTHdLK05WV3FQWVE1Z0lHL0pVR09YR3lsQ0Vv?=
 =?utf-8?B?NllRaGhjcHRxeEYzUnhQYkIwL1o1SVdKdDEwaWExU2ViODdBdTU2NGsxZXpr?=
 =?utf-8?B?U2wyVy9SamYyV0NNVE1DVFdQam9ZaHpsTmZwdmFUbG90T1VCZWNvYkdzaUQ3?=
 =?utf-8?B?NGtaaXVvYjdhaEVVU2lGbDlGZEFyU2FKTnRtOThaNHBORXE5N1pYc08wcTBa?=
 =?utf-8?B?SWFHTG1JWkJNMDMyR29TaWt3ekxkeGxLc2FRVEVFS2VsbmxaYXZ3eUFOQkhI?=
 =?utf-8?Q?RICJ3BDn1m4X4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VHkzYW83SXFlLzM1UGZmT1JBRFYzVmpPMkJUZElzOEJpNnpZQis0T2ZlUXYr?=
 =?utf-8?B?cjJlTElNVnVzSWYwWjcxNlBTTjJQMWJHMkZYVWo0eFZ0SU04L3VzdTh0cjBi?=
 =?utf-8?B?Zlh1OW1GS0tNS3gzVEdPcXhxeXpjcHJ2V3BhT3VFejdlZUcrZzd6emk4SHNn?=
 =?utf-8?B?SXd6Q1BUSFdNSGExK1U2OVl6aE1WVUltRkhidkhQNDh1Rmt6OFFoempBN3Y3?=
 =?utf-8?B?dzIzTHpDNXhBNEpaNFZra1YrcFcxeGZCZ1FzUkxhbExFRy9lQUhsT1Nnd05D?=
 =?utf-8?B?NlppTmNYaDVHMlpOOGxJQTdoSUkwZ3kyaWFqMjl1UVN0SGc4aG5KOTgzWU1x?=
 =?utf-8?B?OUE2UytEUmx4bDRTRHJwL0xDdktqYUtUNkFIZXJ3cStxRUpjTk9aZTEwZFpI?=
 =?utf-8?B?bFJYUXVFWDBzcERiWE5pTjl2bzMyMGkyZjNyTjN2ZEVEeGZOTTROdkNFeUVo?=
 =?utf-8?B?amxHTWhhVWMzOWt6cFlVelRRWXVIc3VIOFZwcXhDejVzUzU3amlFeGxqSzVq?=
 =?utf-8?B?U1dMZ3ZBNSt6T0x1ZE9ZS01ZeStvQ3gwUUF4b0F4TCtkWUJLTER2U2M1VzFO?=
 =?utf-8?B?WVBlTjRxNFZYakNIaWRXUnJJa2EzeWlPSVVzZW5QS0Q5K2FDQ3MxRFpWQ29P?=
 =?utf-8?B?aml2dEVub2tKUm9IWjZCVkc1ZlRYdHI1dStjeXN2RmpBYWM0V3JZQnFEOERh?=
 =?utf-8?B?UHdvbGxGZjc0VVdCU0syYVZmL1daclUrM2NZdGM0VGdGYnlabzZKcktmalk1?=
 =?utf-8?B?V2d0WTRyV3lFLzhhVXJwdGl1cUZaUVI4K2JsVms2NHcrdGh6YUNxeXYxNHZU?=
 =?utf-8?B?T3J4QVhaVGk2NWNBZTZEUmRYdm1XY3JEWjM5cEdWQi80NmYxWEJ0Y2tzYmJu?=
 =?utf-8?B?VzF4MFIzSVQ4bEZNKyt5cjE1bzE2UTZpMFdtWENyUlNDeDREYUtOOFAyUzZr?=
 =?utf-8?B?aVk0bUU0SVZSZFl6L3lobXluSGtQQkQ0K3RzQ05DNTJyaTNnWjZpWU1aTjQ0?=
 =?utf-8?B?QVdaczF0b2VlcjVyQ3oyNkdvc2JXMDJ6c0lIblEvSjFRdHhRbHpNVHd0RlNk?=
 =?utf-8?B?VDRrMFhXNkdSVWluMWhHTytRMU5aWlRlbjJFRmZiRG1FblpXMFhic3AwUEtk?=
 =?utf-8?B?OTE2SFJFSkpSRzVPVFhjNHdyLzNORWhVeFZTd1paYzVKSjczcVZWTEFjU1VB?=
 =?utf-8?B?OG90a2tISFRiVmtlVHVPZVhxSlhHMTFTM3haZDB0OWg0NksyZWNnVXlMeWZX?=
 =?utf-8?B?N3Q0L0hsc3lrWFNUQlJiVHhQUXFsRVNjbWFWQXhNd1FzR1NncnY3eC9aaDlX?=
 =?utf-8?B?aWE3RU1lMjBQQ1NvWE9sd015THhxK0RwT1Q0QncwNmo5M0trR1NvcFMxTER5?=
 =?utf-8?B?dllrTUV1ZFlvK245RHRORUE3NTQ5WHluK0NGdDhzOFdiejBnSFZ5UjRuNWlZ?=
 =?utf-8?B?MXJEcU9UUi92QVdLa0RCOGhrdHNBRCt5S0ZsdGpwNTJ1WENmODBQNTczU0pK?=
 =?utf-8?B?MVBObkExRkplTldHcHQzMjk1VThyYjlObkVvSUFMNEt4bkxnbDVuaW9iTDVs?=
 =?utf-8?B?S2ROVUdKb1dVVGZBUjROYzJZaEdrZEYvUU15Nk9YWXoxV1oyOWpyMkRvSGhh?=
 =?utf-8?B?SCttcFVRUU94MHZ2YnRlelpjc2gxc0NoZFdwbFVpYW9GUFd4bVZtaUpBejg0?=
 =?utf-8?B?RXloTVAyN0RIMU92NWhNMUZJdU1FUGxyRlhEY2xoN2pxdHk1ZFAzYnZOd0FD?=
 =?utf-8?B?cjFJWTdqbHl0NXR4MFlNaWUwcjE2UmxOQjRiN0Z4anpQTEVONGxKWHBPcFU3?=
 =?utf-8?B?UksxWC84M1J5RmU2WlRyZkRIaS9VL2lSaFZlZ0E5M2VSSm9oMmtkakJQT0xw?=
 =?utf-8?B?d3REOGhKZ2JsdTY3N1ZIZ1ROOHJMMWVraEM4RTA0NkVnMW44VEZ2VGVIYUVo?=
 =?utf-8?B?OW5GTnpZbFhLT3dCQzNPYXRnU0xVdlphbGwxTkNUTlA0cDhEVDRhY3lFR1hF?=
 =?utf-8?B?QXFXYzlpeXEwb0w2QWkveXJKQjR2YjhEYnVWeWlyVk5ZeHlhRmEwLzQzZ3dp?=
 =?utf-8?B?UjA5azl5bjJRZXVzRlJXRHpzdjhYNUwwUnZXUUs2aVZ1TDAya2R2eWhlb2xh?=
 =?utf-8?Q?2vDHcnLfaT/0sVJX/ZihroZSm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35bb8767-2f43-41c0-de6d-08ddeb798571
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 06:08:52.1452
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DdSYgwr8iF0+M+1xwEtRIlQOdKVZcfmfMZNTnHjRy7bvzaYEV8EZqspVSYGIs1xO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7091



On 9/3/25 22:47, Rob Herring wrote:
> On Wed, Sep 03, 2025 at 03:29:05PM +0530, Manikanta Guntupalli wrote:
>> Add device tree binding documentation for the AMD I3C master controller.
>>
>> Signed-off-by: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
>> ---
>> Changes for V2:
>> Updated commit subject and description.
>> Moved allOf to after required.
>> Removed xlnx,num-targets property.
>>
>> Changes for V3:
>> Updated commit description.
>> Corrected the order of properties and removed resets property.
>> Added compatible to required list.
>> Added interrupts to example.
>> ---
>>   .../devicetree/bindings/i3c/xlnx,axi-i3c.yaml | 53 +++++++++++++++++++
>>   1 file changed, 53 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/i3c/xlnx,axi-i3c.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/i3c/xlnx,axi-i3c.yaml b/Documentation/devicetree/bindings/i3c/xlnx,axi-i3c.yaml
>> new file mode 100644
>> index 000000000000..32f73c31121e
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/i3c/xlnx,axi-i3c.yaml
>> @@ -0,0 +1,53 @@
>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/i3c/xlnx,axi-i3c.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: AMD I3C master
>> +
>> +maintainers:
>> +  - Manikanta Guntupalli <manikanta.guntupalli@amd.com>
>> +
>> +description:
>> +  The AXI-I3C IP is an I3C Controller with an AXI4-Lite interface, compatible
>> +  with the MIPI I3C Specification v1.1.1. The design includes bidirectional I/O
>> +  buffers that implement open collector drivers for the SDA and SCL signals.
>> +  External pull-up resistors are required to properly hold the bus at a Logic-1
>> +  level when the drivers are released.
>> +
>> +properties:
>> +  compatible:
>> +    const: xlnx,axi-i3c-1.0
> 
> Where does the version number come from? This must correspond to some
> h/w documentation or it is useless.

yes it corresponds to AXI I3C Bus Interface v1.0 Product Guide (PG439)
https://docs.amd.com/r/en-US/pg439-axi-i3c

All these soft IPs are using numbering schema.

Thanks,
Michal



