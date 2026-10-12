Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010034.outbound.protection.outlook.com [52.101.56.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29AD3B19B7;
	Mon, 12 Oct 2026 19:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791831933; cv=fail; b=jDjwGJtpK7OySW5Uba9DweuDA5B6F+Xit6PfYLS8oOmEVkVlY+8/FF5efHJhJwl+ezBsbfi8DXrFZokFwIGjwDWgGUUciP5F63/Z0uPDCvM1WAQnsY4cmpsnx9Y9rcxMdM+VMocPepK+k6QkNnrQP+aEqbRlHnDwRmjQ8DP40w8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791831933; c=relaxed/simple;
	bh=sfWEDQ1GqXVy4vVbpvAsTfNgFFVTjjewQfzCuUC8gek=;
	h=Message-ID:Date:To:Cc:References:Subject:From:In-Reply-To:
	 Content-Type:MIME-Version; b=g4d0TeatRPRHwhWNfsK/f41nJIWd7NXEkxU+WRMhhODIqlXEG78ping+ONgm0RoQTZDaPPhUnje/mpI+gHlGZEmETUEuYTaKTb319STliQjr9eVyVruxrr3GuykEnPImBje8bJTggxeiAKC/LuamU9LHZuvhDj3wT+9DUUp0gfc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=citrix.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=Uht2ybnK; arc=fail smtp.client-ip=52.101.56.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=citrix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="Uht2ybnK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LLQDgzoCrqxVkKItofgPayVYt47lVhBiR7211UCESMI5l3jzeacecyYDBuwZJoCBAOqAcCt6+36ssb+bykgzHk6TJCuxgTVAUi/YnVmqI/i5vr3Rv+6n7D3d3/osygGRlgOJQJZXREiypCHhBZHCbqIRvGg598YYgD/4BwnjqjgrW2pyBS9bm/vxU1suX1w8T43ImArEv3x3EFBry4lCrLRNPzRByjKdogAnfWjFsBQFFAT6vO/ssNgLljHYfJ62k8TfUDnn1PmRQb7AMfY5/oMvZ+Rbie8SvxH2wFKJVos98oWqhsi7qyhFW3hL/3PkZNGwPtNWWulzPsY/E2HOpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HYMNgiNBX4JdD7nOA+cpJP3u2QRzJHQWyD/xIna+4uU=;
 b=jvtUrodWVbj2vp5Fld50p/8ZP65ZA3Qx9IjdVvRbFqCQkfEwvqmQbsNDzQWLBfdl1tRO2Gxq/wBlu+Kf3PpbEBcST88CZDrCMtPoJdTvE1VEp8dgH1XvDMqdtH55lIHEps9btFk2m9cOg/htxYSeBl+I80LWgQIpsAVIJdYOtOzS/b+Ied76J47duOJHQkFJufXS6DHv/gujlp5mg00QGQ1qApcQeSrgogqnr45WIwzeCojeMKvf3SpG8xc7H3+MUuMK41vdkndgEs9sXTdicrQiolm6Co3WvJbqo2wVfxC21CCZ6j6c9YvZOmEWosOXBOicOeNxDYQVxcyfJgUVSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=citrix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HYMNgiNBX4JdD7nOA+cpJP3u2QRzJHQWyD/xIna+4uU=;
 b=Uht2ybnKTx7sdyd3wIvnD6lNNV7ThUCrogi7G5iZT/GzQRQZdfuLy7nhB0IVXTuFSAqtFC3rWloGAxEm31PvDFZni0EQBYDoFAEwDIAhFO2/xeqr3TNfRqyr1aKdGojZ63omL2DyynAt/3uOoeIpWLN27YMjjh3i2vj12ouZGiM=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
Received: from CH8PR03MB8275.namprd03.prod.outlook.com (2603:10b6:610:2b9::7)
 by MW4PR03MB6588.namprd03.prod.outlook.com (2603:10b6:303:12b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Mon, 12 Oct
 2026 19:05:26 +0000
Received: from CH8PR03MB8275.namprd03.prod.outlook.com
 ([fe80::a70d:dc32:bba8:ce37]) by CH8PR03MB8275.namprd03.prod.outlook.com
 ([fe80::a70d:dc32:bba8:ce37%7]) with mapi id 15.21.0496.021; Mon, 12 Oct 2026
 19:05:26 +0000
Message-ID: <8aae2418-38e1-479a-bf82-df65acde0ffd@citrix.com>
Date: Mon, 12 Oct 2026 20:05:21 +0100
User-Agent: Mozilla Thunderbird
To: peterz@infradead.org, kees@kernel.org
Cc: Andrew Cooper <andrew.cooper3@citrix.com>, bp@alien8.de,
 dave.hansen@linux.intel.com, hpa@zytor.com, justinstitt@google.com,
 linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev, mingo@redhat.com, morbo@google.com, nathan@kernel.org,
 ndesaulniers@google.com, samitolvanen@google.com, tglx@kernel.org,
 x86@kernel.org
References: <20261012091601.GN4121339@noisy.programming.kicks-ass.net>
Subject: Re: [PATCH 2/3] x86/kcfi: Emit the FineIBT paranoid "cs" prefix as a
 byte
Content-Language: en-GB
From: Andrew Cooper <andrew.cooper3@citrix.com>
Autocrypt: addr=andrew.cooper3@citrix.com; keydata=
 xsFNBFLhNn8BEADVhE+Hb8i0GV6mihnnr/uiQQdPF8kUoFzCOPXkf7jQ5sLYeJa0cQi6Penp
 VtiFYznTairnVsN5J+ujSTIb+OlMSJUWV4opS7WVNnxHbFTPYZVQ3erv7NKc2iVizCRZ2Kxn
 srM1oPXWRic8BIAdYOKOloF2300SL/bIpeD+x7h3w9B/qez7nOin5NzkxgFoaUeIal12pXSR
 Q354FKFoy6Vh96gc4VRqte3jw8mPuJQpfws+Pb+swvSf/i1q1+1I4jsRQQh2m6OTADHIqg2E
 ofTYAEh7R5HfPx0EXoEDMdRjOeKn8+vvkAwhviWXTHlG3R1QkbE5M/oywnZ83udJmi+lxjJ5
 YhQ5IzomvJ16H0Bq+TLyVLO/VRksp1VR9HxCzItLNCS8PdpYYz5TC204ViycobYU65WMpzWe
 LFAGn8jSS25XIpqv0Y9k87dLbctKKA14Ifw2kq5OIVu2FuX+3i446JOa2vpCI9GcjCzi3oHV
 e00bzYiHMIl0FICrNJU0Kjho8pdo0m2uxkn6SYEpogAy9pnatUlO+erL4LqFUO7GXSdBRbw5
 gNt25XTLdSFuZtMxkY3tq8MFss5QnjhehCVPEpE6y9ZjI4XB8ad1G4oBHVGK5LMsvg22PfMJ
 ISWFSHoF/B5+lHkCKWkFxZ0gZn33ju5n6/FOdEx4B8cMJt+cWwARAQABzSlBbmRyZXcgQ29v
 cGVyIDxhbmRyZXcuY29vcGVyM0BjaXRyaXguY29tPsLBegQTAQgAJAIbAwULCQgHAwUVCgkI
 CwUWAgMBAAIeAQIXgAUCWKD95wIZAQAKCRBlw/kGpdefoHbdD/9AIoR3k6fKl+RFiFpyAhvO
 59ttDFI7nIAnlYngev2XUR3acFElJATHSDO0ju+hqWqAb8kVijXLops0gOfqt3VPZq9cuHlh
 IMDquatGLzAadfFx2eQYIYT+FYuMoPZy/aTUazmJIDVxP7L383grjIkn+7tAv+qeDfE+txL4
 SAm1UHNvmdfgL2/lcmL3xRh7sub3nJilM93RWX1Pe5LBSDXO45uzCGEdst6uSlzYR/MEr+5Z
 JQQ32JV64zwvf/aKaagSQSQMYNX9JFgfZ3TKWC1KJQbX5ssoX/5hNLqxMcZV3TN7kU8I3kjK
 mPec9+1nECOjjJSO/h4P0sBZyIUGfguwzhEeGf4sMCuSEM4xjCnwiBwftR17sr0spYcOpqET
 ZGcAmyYcNjy6CYadNCnfR40vhhWuCfNCBzWnUW0lFoo12wb0YnzoOLjvfD6OL3JjIUJNOmJy
 RCsJ5IA/Iz33RhSVRmROu+TztwuThClw63g7+hoyewv7BemKyuU6FTVhjjW+XUWmS/FzknSi
 dAG+insr0746cTPpSkGl3KAXeWDGJzve7/SBBfyznWCMGaf8E2P1oOdIZRxHgWj0zNr1+ooF
 /PzgLPiCI4OMUttTlEKChgbUTQ+5o0P080JojqfXwbPAyumbaYcQNiH1/xYbJdOFSiBv9rpt
 TQTBLzDKXok86M7BTQRS4TZ/ARAAkgqudHsp+hd82UVkvgnlqZjzz2vyrYfz7bkPtXaGb9H4
 Rfo7mQsEQavEBdWWjbga6eMnDqtu+FC+qeTGYebToxEyp2lKDSoAsvt8w82tIlP/EbmRbDVn
 7bhjBlfRcFjVYw8uVDPptT0TV47vpoCVkTwcyb6OltJrvg/QzV9f07DJswuda1JH3/qvYu0p
 vjPnYvCq4NsqY2XSdAJ02HrdYPFtNyPEntu1n1KK+gJrstjtw7KsZ4ygXYrsm/oCBiVW/OgU
 g/XIlGErkrxe4vQvJyVwg6YH653YTX5hLLUEL1NS4TCo47RP+wi6y+TnuAL36UtK/uFyEuPy
 wwrDVcC4cIFhYSfsO0BumEI65yu7a8aHbGfq2lW251UcoU48Z27ZUUZd2Dr6O/n8poQHbaTd
 6bJJSjzGGHZVbRP9UQ3lkmkmc0+XCHmj5WhwNNYjgbbmML7y0fsJT5RgvefAIFfHBg7fTY/i
 kBEimoUsTEQz+N4hbKwo1hULfVxDJStE4sbPhjbsPCrlXf6W9CxSyQ0qmZ2bXsLQYRj2xqd1
 bpA+1o1j2N4/au1R/uSiUFjewJdT/LX1EklKDcQwpk06Af/N7VZtSfEJeRV04unbsKVXWZAk
 uAJyDDKN99ziC0Wz5kcPyVD1HNf8bgaqGDzrv3TfYjwqayRFcMf7xJaL9xXedMcAEQEAAcLB
 XwQYAQgACQUCUuE2fwIbDAAKCRBlw/kGpdefoG4XEACD1Qf/er8EA7g23HMxYWd3FXHThrVQ
 HgiGdk5Yh632vjOm9L4sd/GCEACVQKjsu98e8o3ysitFlznEns5EAAXEbITrgKWXDDUWGYxd
 pnjj2u+GkVdsOAGk0kxczX6s+VRBhpbBI2PWnOsRJgU2n10PZ3mZD4Xu9kU2IXYmuW+e5KCA
 vTArRUdCrAtIa1k01sPipPPw6dfxx2e5asy21YOytzxuWFfJTGnVxZZSCyLUO83sh6OZhJkk
 b9rxL9wPmpN/t2IPaEKoAc0FTQZS36wAMOXkBh24PQ9gaLJvfPKpNzGD8XWR5HHF0NLIJhgg
 4ZlEXQ2fVp3XrtocHqhu4UZR4koCijgB8sB7Tb0GCpwK+C4UePdFLfhKyRdSXuvY3AHJd4CP
 4JzW0Bzq/WXY3XMOzUTYApGQpnUpdOmuQSfpV9MQO+/jo7r6yPbxT7CwRS5dcQPzUiuHLK9i
 nvjREdh84qycnx0/6dDroYhp0DFv4udxuAvt1h4wGwTPRQZerSm4xaYegEFusyhbZrI0U9tJ
 B8WrhBLXDiYlyJT6zOV2yZFuW47VrLsjYnHwn27hmxTC/7tvG3euCklmkn9Sl9IAKFu29RSo
 d5bD8kMSCYsTqtTfT6W4A3qHGvIDta3ptLYpIAOD2sY3GYq2nf3Bbzx81wZK14JdDDHUX2Rs
 6+ahAA==
In-Reply-To: <20261012091601.GN4121339@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PR1P264CA0165.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:347::15) To CH8PR03MB8275.namprd03.prod.outlook.com
 (2603:10b6:610:2b9::7)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH8PR03MB8275:EE_|MW4PR03MB6588:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ce865b8-729c-48ca-c436-08df2893c641
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|366016|23010399003|56012099006|11063799006|10067099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	8BhyrfMu4moIPDYmv3SnMYCV14ZVGh7WN+C7U9qPiPuK5uaLjhdhv9M5K7x9i8PWGygBrxRelN5ojoLrMIyI4PIoutrimnBFHGTfSdNbCzLzGFOpaOjPTpv/bTmU32HtPlNUt1FINaXmlvaJo7yoIoIE1NzCzT44p4shG9Z61vuaK1Y7LHHqURLt0mE4WhKyrY5CE8jbfaNSyRQCG1JWMOeAFXHGDOtdcgnUZSGSn7Dec1QKOxEqyU0h47a5mKt34IdSX33zR4e+NoFGNlJEACNXhQofsw3jDPE4EuH++t1Fg6Y6trs9a+AZDx2W7+klSu+7vcaQRTYjiIFj+yw8SZ8uPpd/4FY/PwU27Ll3LVX3or5po+9beJyoVd6T7Kc6oWQAHe2qAhWBRej3QZhsZpj76wzrdGMLvRR9OjG7/LRYA6C9bxjBhCcsffMYa6R5EpdoZ+RaMxr+Oy93mo8aZ6QSJx6+W37OYHrJIw2gGs79t1LWNhGfhL0nGaDk6CnHy4MkprjnPsP7pdtWb1k3/cIAoYUjUV6K+eqX0Sc3sE4V4Arg8C19upPLf3L9y6SqxbX/Wdf/kOSIdXIN8zIx8BFEaTypQQdc8MTjGt2huTkeMMxOwT2mi+Jud6TcEiAMAg0Qd9X+0lMbHwduyuJVueLPfeJs57rkj+lAu5CkOlA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH8PR03MB8275.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(23010399003)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aDRiaER1cmV0TVZmZk1FVWwvNUx5QnR2L0Q3L0tBcFZ6SDd6WUFMQmxFa3pV?=
 =?utf-8?B?K1p6QTRjVFByYWx6akNIQkNJRTZ1enhac213ODUrcUlHUmZDVnZHcGZ3eWdJ?=
 =?utf-8?B?U0MvQzRvcVpUTGkvQS9ndDhwaWdKZXYzUllWUXQ1TjRlUWlVTmpueS9JREpK?=
 =?utf-8?B?eUl3N0wrNEVOOVBKN0UzK3FFN0RrdW5rd1YvdHFmMEdSUzcyMFo3SHhrSm5u?=
 =?utf-8?B?T1RaK0NJaXlqVDZWWk9MT2JvcUc3T0U0T0FkeWtMWTU3ZFJDcFhlTk9zYWQx?=
 =?utf-8?B?Ujk1aHNUQzdiK2pOUHYyQnkyWmhLNEtnaUJ5NkhzcnAwdFpYRzNFUG0yL3ha?=
 =?utf-8?B?OHd1SnRhdTJ0U0dwUS9wcXI4REJMRXFCcDVNY0VaQ3lXc2RubFZnSlBGK3Vk?=
 =?utf-8?B?b0JlWWdubDBUZlBjMUNIY0dsZWRDTndLczBONG5aNU1YalMyNzdRZTEyWlhO?=
 =?utf-8?B?OFdmdlJDUW1kQlZPUGYxMXJhY0xlVThMcFhzMVpOcFdMS3B2NnpmVHVPSkxB?=
 =?utf-8?B?NDR5ZGp2bXY5SnpnczhKUWlGNHFzWmhsT2M5enRETEwySERQdnNUUG5IcVZ2?=
 =?utf-8?B?dlJ0SHdoZjUvb216OVN2NE5wK0w3bkR3TWdBQkVpZ2RNTS90Y0txRXYvZ29p?=
 =?utf-8?B?QUNnc2dqbkdWRldtYUpJVUE1OTlwUXk5R2tUb0E2cmhILzBRNEhDY2hIUThR?=
 =?utf-8?B?cXBqcUFsYWtNdndka1dmU0RPSEVQL1Y0dkRYVDYxZ0NYNHZIbWFZMVcrcWVr?=
 =?utf-8?B?R2NsNlkxSmVwbFE5REErUXRlTGxobzM3cUR3eG5rK0Q5VHZmdkxGZTVPZGlz?=
 =?utf-8?B?S09ZSnk5LytpaWtwL2ZEQkNIaXFuWE03a0JlKzZTdjhOVEw1S1ovZlg2UTkv?=
 =?utf-8?B?c3lMWFMxNUp4WnpSaUtyY3V2VEp5dlVUS2hLT09aK2NxaDNHZ3FvQ25xbVNC?=
 =?utf-8?B?ZmVFdHQ3SWo0bFE5NXRTU2c3SUIzOWJyaFNFak9RdzJFeisyajhycnkxcnFw?=
 =?utf-8?B?MFd4R0x4TC8wQ3RCYnQyNDh2KzgvdTJmeEZuUG5EcFl3MGxlN01JSThWOHJH?=
 =?utf-8?B?VlI5aTROVGJiZWJEQnVvWVNiTm9HcHdiL0tEUG1majVCeGpFMnJOcis4ZFFD?=
 =?utf-8?B?R2ROQmI5RjN6VFRXZDJYQU1wWUF4NkoyTmcvcGhLUkRiN0hVSUhPWG1xbXd2?=
 =?utf-8?B?YnNCbENjZStsNGpGaUVtRDZibFpOSmcxUXZuc09OYmxVamxubnp4U3lRRXlo?=
 =?utf-8?B?TzNQRVhXYzF6THh6cHZmSnh4c2traUh0bmFjQzY3YWhPMTRGMHErOHJKeGdi?=
 =?utf-8?B?Y0dyQkt3Qk9mTlg2dlhUcURQK2FOKzRDWEM5L3k5VHh0cDNSWHIzYnVvQ3Bl?=
 =?utf-8?B?NnZPS0tzdzdsSTYyY1FQM2RiOW1HZWJMWFN5dXFzcGVGeStNTGlZZ3ZtMHQ3?=
 =?utf-8?B?YVN4R0lBNmE2ZmNZTEhaQmFaOERWU0hsU21uZG5jZW1tREJFbUtFWlUwcS9r?=
 =?utf-8?B?M1BnaXFIVkFUUThzUDUzL01Mek5mOUtBdlorbkQyMEpHdkIraW8xMEFoTGRp?=
 =?utf-8?B?Y1N3YjZkaVhyenJWbHI1M3ZtaS9VYUhFTHV6enVJYlRhd1ViTVBORm8rdXhw?=
 =?utf-8?B?ZndoTUpiU3ZLN2FaYjgzYmd3MTY4ZmxQRG42SnRzNmY5VExGZG1yTlBwc3Vo?=
 =?utf-8?B?MTVCK245bEVNdjlTbEFEZkRVZ3ZsNkJtNEpkQmNFWUs1TjE0eGU2SnE2L1Jt?=
 =?utf-8?B?NEc2anNCQ0dsNXREMXY5UnMvMkpMS3pWZkVaVzRDdDUzNEdoOFc1alhVcU8z?=
 =?utf-8?B?UjBabDdLc2hJTUlyR2tFUXpwU1JiQWQ3Kyt6N2d2YS9DeGNDZVZyQUo5RDNL?=
 =?utf-8?B?cURQMUdzakJ3Ykx1RFJWV1EwWS9lYzVhVjBieHJoWitLSit4WHA5MnI1L3Bo?=
 =?utf-8?B?enFaYW5lb050TGxvZklOdkRNNE05YStmN2dReWluSmxIMy9IcXZ1OXM3VVg5?=
 =?utf-8?B?Z3VzYTR1UG1JMkNxRFBIUnh5ZUNYdS9UZlh0cUJnWC9MQU9tQnlHZVdOejBn?=
 =?utf-8?B?Y1J2UXQ3blVyTTNLLzU2WGF6UEJYNkVHdzUxQ2VTOVpBem9qaDVyTTczVjdD?=
 =?utf-8?B?ZW05dzlwOHRPamM3cHN1bVRPWENRK0xCUmVpK1NnS21DSjRKQ09zMXRUcVBh?=
 =?utf-8?B?TGN4T1VIeERaMGFDVE1sV1AxSGdid3N2b1IrN1RDTTF2bFRjdGJJT0dtbEps?=
 =?utf-8?B?QkRpbzhad01WT3VqQURwQ2hpUVVjL2svRVRsL21Dcmo4WTZTV0FPMjVVR3Yr?=
 =?utf-8?B?MTBtQmx4MjB3VWdyNGNLZ3gyU0VSWjNlQXdkSEpzMTVrdU1ySkRmZz09?=
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ce865b8-729c-48ca-c436-08df2893c641
X-MS-Exchange-CrossTenant-AuthSource: CH8PR03MB8275.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 19:05:26.2484
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XBlBElep/qPLvGx36ywr9WHYAH7x+T9rdpUuYuAI2GJC1xy/mjHaldYfT6DWOvdVxlI1fgC8iijnCMKKt4NhQeLDAbl6tHL3W9PbgWlzSpc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR03MB6588

> On Mon, Oct 12, 2026 at 02:04:25AM -0700, Kees Cook wrote:
>> The "cs" prefix on the LEA in the FineIBT paranoid caller template is
>> padding: it places the LEA's 0xf0 immediate byte where it doubles as the
>> LOCK prefix that makes the failing Jcc raise #UD. GNU as warns about it
>> in every CONFIG_FINEIBT=y build:
>>
>>   Warning: segment override on `lea' is ineffectual
> Shees...

This is a binutils bug.  Can't we fix it here?

The claim in the warning is simply not true.  This is an example where
it absolutely does matter, and it also matters for legibility that we
can avoid writing raw hex.

~Andrew
