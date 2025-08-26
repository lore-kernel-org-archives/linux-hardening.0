Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013047.outbound.protection.outlook.com [52.101.72.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF46B31A577;
	Tue, 26 Aug 2025 15:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756223864; cv=fail; b=ekJ7o+xM7T8Nm6nwuN24r9KdOWwQpXPzo0RlXUSzEFygg7SHvTPEf4UhHtxF5g5XsvSqPjR5YJYL+pQngHvmy6kz+gLleI7zjsPpvLiXkLIYAuuxtcPUG5dS17q9Fjv2zFTJEY7iRHvl65S6nGH//WG3+ILQSDsr+pqdXkXjkNk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756223864; c=relaxed/simple;
	bh=D9soZQk+xEJkQpghREteupPEKG4P0O5NmSDzGoP5xo0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sQoc35vUsxMqbOZCoiWm1KLODcd+e8wQVn31eelNIwzdNtNhyhsM6xxy9EgJjK9lrjBttkJ2SreY3+Y26g+zVAT2kX0111CM//FyCF4tVmFKKoZWzaUn7wXNqJ8Xu9vQTYB0qdILd1wCSVHdeX2lIW/33noFdeRyIb7NdM06yyk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=DTqV6KP3; arc=fail smtp.client-ip=52.101.72.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="DTqV6KP3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L44rWbuMxMQO0AKJWSOzbMuLXcuGDfflmt+qvyI5+RWg+tJ/d+l13I77Gjvj8ovpRVGg1O/PqQWQJ1AgAZPi7Y8BYmRbBJk7NlBZyiLTFEE/5JkeDBdfI6ami8r8VBOdQa8l/92g52J8gTltRXH74hXs0+0Kk0VVPAth8yhavcLzYmKptmm6eGJCH861UxNco7SZ1AcnP4lBm/FwVvvlfTjpm0RZg7EqKFvkPAPH3F+nyCFNohCcsYsJ4/oQkM2KT+z633EY/NmZ0qNAVW8UqjFrVX3Z1Zu8Agcb/06Z+dPfY88E+ke93V+dJEt75mW6Prgsjs36wtKpY0hAuC4mQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a0CVZtbPyhOm26uaGtmTA1rxwB8KgPZ8V59l8FAjNZ4=;
 b=w/ySlNzl2MduwRrT7m67lLVVOAz6j7hfK908PuK2q9qjUUTTf+3TdLYipd7bCbkHaT7cOvcxGBBnG+fw3iOup0Qpq5lPUHX/9GNcgUgsjXRIDF/T/9GuKw9H4kW1+Y9rWtsBol194umVjw4g7hpOqwwhz51omhZaq/w6jLD9uVpsgqGL1hmoTqUmbdw/xLcvrn4GWey3n3dPwUcE7qFeF/yNsV+LYFnXYTXyjNcgAqaSh0XKlmkYL1M6Fl5wDTHmbGCM2EqgZqFYfQL8qqeQJ24v1nVPufwlyEjSdOyQU0YP7/UYM3NHLO9M4TiZuVmQ+yQckri6pAn3deXzN8sOTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a0CVZtbPyhOm26uaGtmTA1rxwB8KgPZ8V59l8FAjNZ4=;
 b=DTqV6KP3PMNa2zf3+yz2pZ+zqlna08wYX1icm6ZUfuu3jX5gd8PTEFfQhpAsfplAqt3uMdXvAEUBcO2w2UMS6JdFVjznEU+EOCyIu32Jwthx6Tglkkl0Op7DEH480mcG5+m5WzJj8qzUWvnRZ/cMA5kLUFuK6FPQABeI4a2Q4SXZa0EFM/3TiysBxfK2hlL3W3HXHF1loOt4DYqpEAduW+rOuYwSzWCMxplObToxNHbBSmw5E18INhHJRaa15PiznEJdo/KDKoyys3OuTQHxv0NsY0pNL5Qzn8trMlnzkjaCGuKK9CHBrom8nRsDWFLhVOM9WcJrfVooqiESEmwI0g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by AS8PR04MB7591.eurprd04.prod.outlook.com (2603:10a6:20b:297::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.10; Tue, 26 Aug
 2025 15:57:36 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d%5]) with mapi id 15.20.9073.009; Tue, 26 Aug 2025
 15:57:36 +0000
Date: Tue, 26 Aug 2025 11:57:28 -0400
From: Frank Li <Frank.li@nxp.com>
To: Jorge Marques <jorge.marques@analog.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-i3c@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, gastmaier@gmail.com,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v7 2/2] i3c: master: Add driver for Analog Devices I3C
 Controller IP
Message-ID: <aK3ZaNK0i72kzWsS@lizhi-Precision-Tower-5810>
References: <20250818-adi-i3c-master-v7-0-f7207902669d@analog.com>
 <20250818-adi-i3c-master-v7-2-f7207902669d@analog.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250818-adi-i3c-master-v7-2-f7207902669d@analog.com>
X-ClientProxiedBy: SJ0PR03CA0113.namprd03.prod.outlook.com
 (2603:10b6:a03:333::28) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|AS8PR04MB7591:EE_
X-MS-Office365-Filtering-Correlation-Id: 450d9b42-41ad-4699-8b59-08dde4b94685
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|366016|1800799024|19092799006|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RWRRVERRaWZOekhrVGRZNUcyd2ZlL3NtU0t2L00zVWJOQUMvNGQ2aHBhY0lz?=
 =?utf-8?B?WmFGZ0NkZXFua296T1UyS0lvTnFyS2NLa0VCaUxhNy9MRTlKOVAvMkhhQnlR?=
 =?utf-8?B?QzdwcWJYME1EZzVnYnZPbUNMYnhzRHhoQUQ1R21pZ1Bsd3d5SFhvSjFWVTdx?=
 =?utf-8?B?ZlAwOUtPTHlKUDFzeExqaytRNENmOGJZeVFKYk5aWTdkaDllb2JzL3JOaG9z?=
 =?utf-8?B?MXE4QS96QnRDOWRwejJNMFpYNkRtUHluam8vT3FiRHpTL3JGR25XM0xtaDJS?=
 =?utf-8?B?L2pkYlhmVGk5aERVTTVJK1BKZ3FOTVNXU2piUWFGVHhNdkdONmhaUmJ2NS9x?=
 =?utf-8?B?QWV5WU5OV1BuMzVhZnpjaVFIeDRBcHVjeU9lMFNzMVV5VnlNWnRDVStEU3dN?=
 =?utf-8?B?b1ZKUTgzWG1VNkYwdFRRVEIwdkxFcWdYck5Db3BnekxlZWtVek92VXJwd0k4?=
 =?utf-8?B?R1R5MWZ3a05tbStwbFA1d3JGU1J5TE5naWNCL2JGVGtEb281WlVnamNSKy8v?=
 =?utf-8?B?Zm5UU2Y0eWJYK0p4Q3lXY1U0Zlp2WU1JMlBwQVlEZ0E4ZFpXdEZNRndBRVBC?=
 =?utf-8?B?bCtSanBWcFEzVXdhNGJzbHFtOHRkOThxaU4xaStSSnZUU0NSSW50cnZEN01z?=
 =?utf-8?B?WGJlVUEwdk5zNWcvSkpXRlliNmVtY3VTWW90Mm1ZT0R4RTVxYWVxK0RsWURH?=
 =?utf-8?B?WDlETEhKWkh4eGltK0JKS2dPZVJnQnRGMWJkR3BRcVFiUHE4R0xGS1I4S0NS?=
 =?utf-8?B?SlBkcDJqZ01QcjVjdDhudlJ3VVB4RUcxUGc2MGRGY0FiUnVNOE5FWmYvbWdy?=
 =?utf-8?B?a014OTM3RlhjUGxYTzA0SHRvRUVlN1Naa0E4dHZBUFl2M0E2ZFdmYXVIMlUv?=
 =?utf-8?B?SEFKbGFGQ0wwdktMaUEvRzQwcFF4KzJNV0RtdmdHd2VqMlMzcTArK2UxUkxD?=
 =?utf-8?B?eXZSazJDWStZOTFNb3VtU0psM05sWjhUMUhQWENKZmRubnRVbUtDdTh0aTZG?=
 =?utf-8?B?UDNwVnNpSys1RW9VTWVxbXlXZ05ka3RyamxLK2YzTGFLd0dsZ01ZUlFOVDhB?=
 =?utf-8?B?RHkrRDRZRmZma1dPaWN0QVhIZURnZitsWDBvQ3FtemZUMldUaXdKY3lnYTFn?=
 =?utf-8?B?cEw5ZzFINHlwUHk2bHJGMVdaanJWNnhRVUtBQkZHVThidEVBbXFRak9DZmtu?=
 =?utf-8?B?alhRczRHZGNzUTlzeldpVGRHLzRCaHZqZWRqOVY4ZXR1T0lmS1g3YWs5VGp1?=
 =?utf-8?B?SFROSVV1eUdvcVdpQ2ZOSmpuamdvNFdkdTdQcVlkOHZHUEY2cFZRQUtRekZD?=
 =?utf-8?B?bWZxQ1hjYTg0RXFwbW5tWVJSYjhEU0d5TUhjWGlOUWZzWXRCNjNKckxiZ25o?=
 =?utf-8?B?T1BoQjdBWVI0Z3VvMzRyQi9FNDIrZ0Y2UFJ0alE2MFdWUjZLaHVyYkRuN1F5?=
 =?utf-8?B?UlF0aFJLUkpkQlVvWTN3bjhiNXlVWFFhS0VqbzdpMmFxNmlwWFIzTGp1R2hS?=
 =?utf-8?B?WllXREhDbUZQU1Y0Vi9kVW9GMUFTN0hKcmN3YmN4aWwrdGx2YlpxUDNLUW9M?=
 =?utf-8?B?MVplTjJMV2FuRGF5WlV4VWRyRy9HNnROZEYxN3FsT2lDOGlVdG9aTGFCN0w1?=
 =?utf-8?B?blU4UVBYclI4RkViQ2tJSEJ1Y2dudklacS9TN25yQW1TU0VFRGU2MmNqM3Zl?=
 =?utf-8?B?RmdkckRPUXMva0ZZQnFvZTJDQlhhNEp2czV4RG1FSHlWVmZoUkZpOWwwOHgz?=
 =?utf-8?B?N2k0Z3JGTGtNNnhTbE1iaUhteTFoV25jWXB1RnFLN21VUjZ6clVQY1ZpajFi?=
 =?utf-8?B?Vm1NYllqNG0vbjVRODljZDBJTERDSEZaUWZZOGF5TlowcHRDM015ckwrWWVX?=
 =?utf-8?B?M3R1NVF1MVdVVXJPQ1dlVk1OellJQjJWRnpma1VoQzM4OFhnOGNMbkdVRkVC?=
 =?utf-8?B?M2xYbksrdjM4a0tCQnlQV0ZBZDVHUUlGV2tYTVpsbkFrSVBUNWhKUml3ckJZ?=
 =?utf-8?B?R3d5clNHUCtBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(366016)(1800799024)(19092799006)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T3R4R1ZNZTluU3k5akpHbzRzdS9pckVGdXpvM3ZjOFN4Nmx3KzNNUTJnZFND?=
 =?utf-8?B?Rk1pU01pcWZqcG1XQjczZWVDeE8vTW4yZ1h0YkFsV2dBV3NGbjRsRjYzY2Q5?=
 =?utf-8?B?U29JR1lwa3A2ZFA0Qk9MaXl5UnJxQkdLZm90cDlpWUIxQ3pqMGZ2RVVSTmZL?=
 =?utf-8?B?WkJ6RHJ2eW5DVUNUbHBnZE05VjJhNmVXbDFUUjNXQStRU3RzOTJXWDdnK3FC?=
 =?utf-8?B?VGloWnh3c2ZTM04zQkR2R0J3MTZKUmFhNWhtZmNXNFprVHRBdjJ6KzVSNnNv?=
 =?utf-8?B?VHZ4QnlrbHNzUEswaWYzUjUyVEpaV1dnV1lPRmtLS0ljb3VnMzRqTXMyU0xP?=
 =?utf-8?B?elo0MFVhY2dJTzNzZWsrZG0rK0NERUNRQ3lJRHY0cmx5aEwrVUpkZTY4TUFX?=
 =?utf-8?B?UjBaWUFqMCtFNTFrRmx1eXV3ZWhtVXNzQUxBUTU4SmQxbCtpT3JkaHBUWlU5?=
 =?utf-8?B?QXdWQWdNUWVLME9QYmVoNnVMQ3NCL0hrb3RKTFA2cFVOUGJ0TTMyY1NXQ1Ri?=
 =?utf-8?B?bHUwTlAxT1RWc0NPUWtGTTVxeDBKOUo5bGpVa29SRUkxUzR2b1FFU0R0bFFV?=
 =?utf-8?B?ZXBlajI0ckF2UWRUUTYwN0hxRUFYRUpySkozdVdkM2huSDlHbExBR0NJZmVZ?=
 =?utf-8?B?UjJNQkpCWk5KenNBQkxWNVMrTjYxY0U0TUFYNWcyR3VHcHFHT296dVNDSzli?=
 =?utf-8?B?MysxVS9CeU91T2FLalA2RVdqS3NJQlZhWmkyUjNnZDkwT1Rvczk1eGlLUlV5?=
 =?utf-8?B?b2h0Y1ZRa3MrSGo2eG5QMHhrUi8vZE5LQktkN2JodHJmSmt5KzVuOXhJYkZB?=
 =?utf-8?B?RW5IWjFWT1R5b2p6aHd3Mkl1RHNUbEY2NEh5S2Q1ZjNhc3A1NlFlWmh2VUJr?=
 =?utf-8?B?K01DcndXTDZLTmV4ZE5UTDJZWnJiVkExejlSZDhDL0F1OTl6WUJIUjEwdHFv?=
 =?utf-8?B?ZXhKMGYxdHBMTTM4Y3oxV3krRUlhMWFsL2R0R1p4RHJXbW1UckRENzVST01N?=
 =?utf-8?B?UWxzcUoyVGZvYnJ6aDMzQms3NytuWFEyQkJkQ3IxR05yeThyb083QmdZV3dv?=
 =?utf-8?B?bkFOZ2NFYXhtQy9tZkpCcm5HY2Z0OTd4UzYxYmtIWWhmdWZIYjVOTzRLQ294?=
 =?utf-8?B?azJ1N2RyczluY1dZaFovM3l0eERaUllobVh4Z081K0FBdlV4SnV5dHJjUU00?=
 =?utf-8?B?QVFuUmV1VElqb0pmMTBDd3puVWtnT2VqOHZka2I5Q2dpRlVkQmQzbUVVdkVG?=
 =?utf-8?B?TmZmRFJmL1RrcTRPZ2o5Ri90SVVERFM4R1g2VUx4S2FkWXk4M05WWGhjanZz?=
 =?utf-8?B?d3VFTlhGNVBmV2h0b0p2QTZCeUZaRnBJQUlWMXdkUUNjMHBuUWNCdmxYMTUw?=
 =?utf-8?B?TTVQZUJPQ1BkWnFoaHlRUVFDVkRmNGcrVGltaDhmU0I5VVJDN3VWMEsraUU5?=
 =?utf-8?B?eVFhOENCRUpWZFprNzdSUzkvRkVQYnE1cUVxOWQyclVkY3ljeWladVQrNU5n?=
 =?utf-8?B?SmN2Z3FqMk1UMDBRNDlXZ0Z4dWxWMTZLUHVuV0N5Tk9BN3FGelp6VlRWQnBC?=
 =?utf-8?B?dEJrdVA5S3Y4TUROdktVc0dENkZqcEwzUXFOcDcvcGs3NEFsWURLS3ljdXJH?=
 =?utf-8?B?Q05VS1V2eG9mOW9pbU4vVXpzRnQrSVFaLzdIcUZwNTE2M0lHSllycFJHbERO?=
 =?utf-8?B?OHBVczk3RnFhc0lZVCtYUFNhRXNRY3hqY0dkR2QydzdQdkk4d0s3djB5Yk10?=
 =?utf-8?B?S3NMc0lDYkRlZDVyeHR6amJGdHgrcFFPZWY3QjZFeVk0eVBCUDdQV2RIRWJr?=
 =?utf-8?B?MTJjQnVOQ0hjcHd4d1N3Y25oVzNJK0RSMFY0U2ZnM3A0NXdoUENJL0tMZTJp?=
 =?utf-8?B?WDAwREJCYm11NDVvK2dnSG1kSE1sbmxBSktCWENrUm5vb0dqWWhxUlp4akhn?=
 =?utf-8?B?OTM5Z1RZUldmcVZ5eGVRc1dwQXgvaU1ZMm9LZzlRVjV2a3R5U2l2ekUxNE1r?=
 =?utf-8?B?SnNheU5zOHp1YjFmU3VqcTRNU2pXc1JqYk1MWFFudVNoOUwyeW9lOUUrMkkr?=
 =?utf-8?B?NGo4dUVwY2Zsbi84VGpQcHFEaXdvS25tV0lYQU5NQkhzb0R5emp1eUVONjZ0?=
 =?utf-8?Q?yPPI=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 450d9b42-41ad-4699-8b59-08dde4b94685
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 15:57:36.2891
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OGrS++5DOAMsVEKazmB8Yb78T6x7bm05fhn2ZQM92O404b83/yBeBRSmT9iLwi+NYpoDL7T+nTucmgufsrUOVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7591

On Mon, Aug 18, 2025 at 01:51:14PM +0200, Jorge Marques wrote:
> Add support for Analog Devices I3C Controller IP, an AXI-interfaced IP
> core that supports I3C and I2C devices, multiple speed-grades and
> I3C IBIs.
>
> Signed-off-by: Jorge Marques <jorge.marques@analog.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>  MAINTAINERS                         |    1 +
>  drivers/i3c/master/Kconfig          |   11 +
>  drivers/i3c/master/Makefile         |    1 +
>  drivers/i3c/master/adi-i3c-master.c | 1019 +++++++++++++++++++++++++++++++++++
>  4 files changed, 1032 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index faa50535b514037ddf97309874ec64aac2013cb6..aeb39657c55a46b89d17c6e4039a2642b62634d0 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11456,6 +11456,7 @@ I3C DRIVER FOR ANALOG DEVICES I3C CONTROLLER IP
>  M:	Jorge Marques <jorge.marques@analog.com>
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/i3c/adi,i3c-master.yaml
> +F:	drivers/i3c/master/adi-i3c-master.c
>
>  I3C DRIVER FOR CADENCE I3C MASTER IP
>  M:	Przemysław Gaj <pgaj@cadence.com>
> diff --git a/drivers/i3c/master/Kconfig b/drivers/i3c/master/Kconfig
> index 13df2944f2ec9a0aa7e4dfa46f9a52ad19ba9bb2..82cf330778d5a789c0df7c10bd527a45549c1594 100644
> --- a/drivers/i3c/master/Kconfig
> +++ b/drivers/i3c/master/Kconfig
> @@ -1,4 +1,15 @@
>  # SPDX-License-Identifier: GPL-2.0-only
> +config ADI_I3C_MASTER
> +	tristate "Analog Devices I3C master driver"
> +	depends on HAS_IOMEM
> +	help
> +	  Support for Analog Devices I3C Controller IP, an AXI-interfaced IP
> +	  core that supports I3C and I2C devices, multiple speed-grades and I3C
> +	  IBIs.
> +
> +	  This driver can also be built as a module. If so, the module will be
> +	  called adi-i3c-master.
> +
>  config CDNS_I3C_MASTER
>  	tristate "Cadence I3C master driver"
>  	depends on HAS_IOMEM
> diff --git a/drivers/i3c/master/Makefile b/drivers/i3c/master/Makefile
> index aac74f3e3851441fd2974f6b1f77c569a9ed1cc6..816a227b6f7acf0a99971e385fdef6a405e20040 100644
> --- a/drivers/i3c/master/Makefile
> +++ b/drivers/i3c/master/Makefile
> @@ -1,4 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0-only
> +obj-$(CONFIG_ADI_I3C_MASTER)		+= adi-i3c-master.o
>  obj-$(CONFIG_CDNS_I3C_MASTER)		+= i3c-master-cdns.o
>  obj-$(CONFIG_DW_I3C_MASTER)		+= dw-i3c-master.o
>  obj-$(CONFIG_AST2600_I3C_MASTER)	+= ast2600-i3c-master.o
> diff --git a/drivers/i3c/master/adi-i3c-master.c b/drivers/i3c/master/adi-i3c-master.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..162f9eed39aa5ef6f656239dcd8bfc5fe6281264
> --- /dev/null
> +++ b/drivers/i3c/master/adi-i3c-master.c
> @@ -0,0 +1,1019 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * I3C Controller driver
> + * Copyright 2025 Analog Devices Inc.
> + * Author: Jorge Marques <jorge.marques@analog.com>
> + */
> +
> +#include <linux/bitops.h>
> +#include <linux/bitfield.h>
> +#include <linux/clk.h>
> +#include <linux/err.h>
> +#include <linux/errno.h>
> +#include <linux/fpga/adi-axi-common.h>
> +#include <linux/i3c/master.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +
> +#include "../internals.h"
> +
> +#define ADI_MAX_DEVS			16
> +#define ADI_HAS_MDB_FROM_BCR(x)		(FIELD_GET(BIT(2), (x)))
> +
> +#define REG_ENABLE			0x040
> +
> +#define REG_PID_L			0x054
> +#define REG_PID_H			0x058
> +#define REG_DCR_BCR_DA			0x05c
> +#define   REG_DCR_BCR_DA_GET_DA(x)	FIELD_GET(GENMASK(22, 16), (x))
> +#define   REG_DCR_BCR_DA_GET_BCR(x)	FIELD_GET(GENMASK(15, 8), (x))
> +#define   REG_DCR_BCR_DA_GET_DCR(x)	FIELD_GET(GENMASK(7, 0), (x))
> +
> +#define REG_IRQ_MASK			0x080
> +#define REG_IRQ_PENDING			0x084
> +#define   REG_IRQ_PENDING_DAA		BIT(7)
> +#define   REG_IRQ_PENDING_IBI		BIT(6)
> +#define   REG_IRQ_PENDING_CMDR		BIT(5)
> +
> +#define REG_CMD_FIFO			0x0d4
> +#define   REG_CMD_FIFO_0_IS_CCC		BIT(22)
> +#define   REG_CMD_FIFO_0_BCAST		BIT(21)
> +#define   REG_CMD_FIFO_0_SR		BIT(20)
> +#define   REG_CMD_FIFO_0_LEN(l)		FIELD_PREP(GENMASK(19, 8), (l))
> +#define   REG_CMD_FIFO_0_DEV_ADDR(a)	FIELD_PREP(GENMASK(7, 1), (a))
> +#define   REG_CMD_FIFO_0_RNW		BIT(0)
> +#define   REG_CMD_FIFO_1_CCC(id)	FIELD_PREP(GENMASK(7, 0), (id))
> +
> +#define REG_CMD_FIFO_ROOM		0x0c0
> +#define REG_CMDR_FIFO			0x0d8
> +#define   REG_CMDR_FIFO_UDA_ERROR	8
> +#define   REG_CMDR_FIFO_NACK_RESP	6
> +#define   REG_CMDR_FIFO_CE2_ERROR	4
> +#define   REG_CMDR_FIFO_CE0_ERROR	1
> +#define   REG_CMDR_FIFO_NO_ERROR	0
> +#define   REG_CMDR_FIFO_ERROR(x)	FIELD_GET(GENMASK(23, 20), (x))
> +#define   REG_CMDR_FIFO_XFER_BYTES(x)	FIELD_GET(GENMASK(19, 8), (x))
> +
> +#define REG_SDO_FIFO			0x0dc
> +#define REG_SDO_FIFO_ROOM		0x0c8
> +#define REG_SDI_FIFO			0x0e0
> +#define REG_IBI_FIFO			0x0e4
> +#define REG_FIFO_STATUS			0x0e8
> +#define   REG_FIFO_STATUS_CMDR_EMPTY	BIT(0)
> +#define   REG_FIFO_STATUS_IBI_EMPTY	BIT(1)
> +
> +#define REG_OPS				0x100
> +#define   REG_OPS_PP_SG_MASK		GENMASK(6, 5)
> +#define   REG_OPS_SET_SG(x)		FIELD_PREP(REG_OPS_PP_SG_MASK, (x))
> +
> +#define REG_IBI_CONFIG			0x140
> +#define   REG_IBI_CONFIG_ENABLE		BIT(0)
> +#define   REG_IBI_CONFIG_LISTEN		BIT(1)
> +
> +#define REG_DEV_CHAR			0x180
> +#define   REG_DEV_CHAR_IS_I2C		BIT(0)
> +#define   REG_DEV_CHAR_IS_ATTACHED	BIT(1)
> +#define   REG_DEV_CHAR_BCR_IBI(x)	FIELD_PREP(GENMASK(3, 2), (x))
> +#define   REG_DEV_CHAR_WEN		BIT(8)
> +#define   REG_DEV_CHAR_ADDR(x)		FIELD_PREP(GENMASK(15, 9), (x))
> +
> +enum speed_grade {PP_SG_UNSET, PP_SG_1MHZ, PP_SG_3MHZ, PP_SG_6MHZ, PP_SG_12MHZ};
> +
> +struct adi_i3c_cmd {
> +	u32 cmd0;
> +	u32 cmd1;
> +	u32 tx_len;
> +	const void *tx_buf;
> +	u32 rx_len;
> +	void *rx_buf;
> +	u32 error;
> +};
> +
> +struct adi_i3c_xfer {
> +	struct list_head node;
> +	struct completion comp;
> +	int ret;
> +	unsigned int ncmds;
> +	unsigned int ncmds_comp;
> +	struct adi_i3c_cmd cmds[] __counted_by(ncmds);
> +};
> +
> +struct adi_i3c_master {
> +	struct i3c_master_controller base;
> +	u32 free_rr_slots;
> +	struct {
> +		unsigned int num_slots;
> +		struct i3c_dev_desc **slots;
> +		spinlock_t lock; /* Protect IBI slot access */
> +	} ibi;
> +	struct {
> +		struct list_head list;
> +		struct adi_i3c_xfer *cur;
> +		spinlock_t lock; /* Protect transfer */
> +	} xferqueue;
> +	void __iomem *regs;
> +	struct clk *clk;
> +	unsigned long i3c_scl_lim;
> +	struct {
> +		u8 addrs[ADI_MAX_DEVS];
> +		u8 index;
> +	} daa;
> +};
> +
> +static inline struct adi_i3c_master *to_adi_i3c_master(struct i3c_master_controller *master)
> +{
> +	return container_of(master, struct adi_i3c_master, base);
> +}
> +
> +static void adi_i3c_master_wr_to_tx_fifo(struct adi_i3c_master *master,
> +					 const u8 *buf, unsigned int nbytes)
> +{
> +	unsigned int n, m;
> +
> +	n = readl(master->regs + REG_SDO_FIFO_ROOM);
> +	m = min(n, nbytes);
> +	i3c_writel_fifo(master->regs + REG_SDO_FIFO, buf, nbytes);
> +}
> +
> +static void adi_i3c_master_rd_from_rx_fifo(struct adi_i3c_master *master,
> +					   u8 *buf, unsigned int nbytes)
> +{
> +	i3c_readl_fifo(master->regs + REG_SDI_FIFO, buf, nbytes);
> +}
> +
> +static bool adi_i3c_master_supports_ccc_cmd(struct i3c_master_controller *m,
> +					    const struct i3c_ccc_cmd *cmd)
> +{
> +	if (cmd->ndests > 1)
> +		return false;
> +
> +	switch (cmd->id) {
> +	case I3C_CCC_ENEC(true):
> +	case I3C_CCC_ENEC(false):
> +	case I3C_CCC_DISEC(true):
> +	case I3C_CCC_DISEC(false):
> +	case I3C_CCC_RSTDAA(true):
> +	case I3C_CCC_RSTDAA(false):
> +	case I3C_CCC_ENTDAA:
> +	case I3C_CCC_SETDASA:
> +	case I3C_CCC_SETNEWDA:
> +	case I3C_CCC_GETMWL:
> +	case I3C_CCC_GETMRL:
> +	case I3C_CCC_GETPID:
> +	case I3C_CCC_GETBCR:
> +	case I3C_CCC_GETDCR:
> +	case I3C_CCC_GETSTATUS:
> +	case I3C_CCC_GETHDRCAP:
> +		return true;
> +	default:
> +		break;
> +	}
> +
> +	return false;
> +}
> +
> +static int adi_i3c_master_disable(struct adi_i3c_master *master)
> +{
> +	writel(0, master->regs + REG_IBI_CONFIG);
> +
> +	return 0;
> +}
> +
> +static struct adi_i3c_xfer *adi_i3c_master_alloc_xfer(struct adi_i3c_master *master,
> +						      unsigned int ncmds)
> +{
> +	struct adi_i3c_xfer *xfer;
> +
> +	xfer = kzalloc(struct_size(xfer, cmds, ncmds), GFP_KERNEL);
> +	if (!xfer)
> +		return NULL;
> +
> +	INIT_LIST_HEAD(&xfer->node);
> +	xfer->ncmds = ncmds;
> +	xfer->ret = -ETIMEDOUT;
> +
> +	return xfer;
> +}
> +
> +static void adi_i3c_master_start_xfer_locked(struct adi_i3c_master *master)
> +{
> +	struct adi_i3c_xfer *xfer = master->xferqueue.cur;
> +	unsigned int i, n, m;
> +
> +	if (!xfer)
> +		return;
> +
> +	for (i = 0; i < xfer->ncmds; i++) {
> +		struct adi_i3c_cmd *cmd = &xfer->cmds[i];
> +
> +		if (!(cmd->cmd0 & REG_CMD_FIFO_0_RNW))
> +			adi_i3c_master_wr_to_tx_fifo(master, cmd->tx_buf, cmd->tx_len);
> +	}
> +
> +	n = readl(master->regs + REG_CMD_FIFO_ROOM);
> +	for (i = 0; i < xfer->ncmds; i++) {
> +		struct adi_i3c_cmd *cmd = &xfer->cmds[i];
> +
> +		m = cmd->cmd0 & REG_CMD_FIFO_0_IS_CCC ? 2 : 1;
> +		if (m > n)
> +			break;
> +		writel(cmd->cmd0, master->regs + REG_CMD_FIFO);
> +		if (cmd->cmd0 & REG_CMD_FIFO_0_IS_CCC)
> +			writel(cmd->cmd1, master->regs + REG_CMD_FIFO);
> +		n -= m;
> +	}
> +}
> +
> +static void adi_i3c_master_end_xfer_locked(struct adi_i3c_master *master,
> +					   u32 pending)
> +{
> +	struct adi_i3c_xfer *xfer = master->xferqueue.cur;
> +	int i, ret = 0;
> +
> +	if (!xfer)
> +		return;
> +
> +	while (!(readl(master->regs + REG_FIFO_STATUS) & REG_FIFO_STATUS_CMDR_EMPTY)) {
> +		struct adi_i3c_cmd *cmd;
> +		u32 cmdr, rx_len;
> +
> +		cmdr = readl(master->regs + REG_CMDR_FIFO);
> +
> +		cmd = &xfer->cmds[xfer->ncmds_comp++];
> +		if (cmd->cmd0 & REG_CMD_FIFO_0_RNW) {
> +			rx_len = min_t(u32, REG_CMDR_FIFO_XFER_BYTES(cmdr), cmd->rx_len);
> +			adi_i3c_master_rd_from_rx_fifo(master, cmd->rx_buf, rx_len);
> +		}
> +		cmd->error = REG_CMDR_FIFO_ERROR(cmdr);
> +	}
> +
> +	for (i = 0; i < xfer->ncmds_comp; i++) {
> +		switch (xfer->cmds[i].error) {
> +		case REG_CMDR_FIFO_NO_ERROR:
> +			break;
> +
> +		case REG_CMDR_FIFO_CE0_ERROR:
> +		case REG_CMDR_FIFO_CE2_ERROR:
> +		case REG_CMDR_FIFO_NACK_RESP:
> +		case REG_CMDR_FIFO_UDA_ERROR:
> +			ret = -EIO;
> +			break;
> +
> +		default:
> +			ret = -EINVAL;
> +			break;
> +		}
> +	}
> +
> +	xfer->ret = ret;
> +
> +	if (xfer->ncmds_comp != xfer->ncmds)
> +		return;
> +
> +	complete(&xfer->comp);
> +
> +	xfer = list_first_entry_or_null(&master->xferqueue.list,
> +					struct adi_i3c_xfer, node);
> +	if (xfer)
> +		list_del_init(&xfer->node);
> +
> +	master->xferqueue.cur = xfer;
> +	adi_i3c_master_start_xfer_locked(master);
> +}
> +
> +static void adi_i3c_master_queue_xfer(struct adi_i3c_master *master,
> +				      struct adi_i3c_xfer *xfer)
> +{
> +	init_completion(&xfer->comp);
> +	guard(spinlock_irqsave)(&master->xferqueue.lock);
> +	if (master->xferqueue.cur) {
> +		list_add_tail(&xfer->node, &master->xferqueue.list);
> +	} else {
> +		master->xferqueue.cur = xfer;
> +		adi_i3c_master_start_xfer_locked(master);
> +	}
> +}
> +
> +static void adi_i3c_master_unqueue_xfer(struct adi_i3c_master *master,
> +					struct adi_i3c_xfer *xfer)
> +{
> +	guard(spinlock_irqsave)(&master->xferqueue.lock);
> +	if (master->xferqueue.cur == xfer)
> +		master->xferqueue.cur = NULL;
> +	else
> +		list_del_init(&xfer->node);
> +
> +	writel(0x01, master->regs + REG_ENABLE);
> +	writel(0x00, master->regs + REG_ENABLE);
> +	writel(REG_IRQ_PENDING_CMDR, master->regs + REG_IRQ_MASK);
> +}
> +
> +static enum i3c_error_code adi_i3c_cmd_get_err(struct adi_i3c_cmd *cmd)
> +{
> +	switch (cmd->error) {
> +	case REG_CMDR_FIFO_CE0_ERROR:
> +		return I3C_ERROR_M0;
> +
> +	case REG_CMDR_FIFO_CE2_ERROR:
> +	case REG_CMDR_FIFO_NACK_RESP:
> +		return I3C_ERROR_M2;
> +
> +	default:
> +		break;
> +	}
> +
> +	return I3C_ERROR_UNKNOWN;
> +}
> +
> +static int adi_i3c_master_send_ccc_cmd(struct i3c_master_controller *m,
> +				       struct i3c_ccc_cmd *cmd)
> +{
> +	struct adi_i3c_master *master = to_adi_i3c_master(m);
> +	struct adi_i3c_xfer *xfer __free(kfree) = NULL;
> +	struct adi_i3c_cmd *ccmd;
> +
> +	xfer = adi_i3c_master_alloc_xfer(master, 1);
> +	if (!xfer)
> +		return -ENOMEM;
> +
> +	ccmd = xfer->cmds;
> +	ccmd->cmd1 = REG_CMD_FIFO_1_CCC(cmd->id);
> +	ccmd->cmd0 = REG_CMD_FIFO_0_IS_CCC |
> +		     REG_CMD_FIFO_0_LEN(cmd->dests[0].payload.len);
> +
> +	if (cmd->id & I3C_CCC_DIRECT)
> +		ccmd->cmd0 |= REG_CMD_FIFO_0_DEV_ADDR(cmd->dests[0].addr);
> +
> +	if (cmd->rnw) {
> +		ccmd->cmd0 |= REG_CMD_FIFO_0_RNW;
> +		ccmd->rx_buf = cmd->dests[0].payload.data;
> +		ccmd->rx_len = cmd->dests[0].payload.len;
> +	} else {
> +		ccmd->tx_buf = cmd->dests[0].payload.data;
> +		ccmd->tx_len = cmd->dests[0].payload.len;
> +	}
> +
> +	adi_i3c_master_queue_xfer(master, xfer);
> +	if (!wait_for_completion_timeout(&xfer->comp, msecs_to_jiffies(1000)))
> +		adi_i3c_master_unqueue_xfer(master, xfer);
> +
> +	cmd->err = adi_i3c_cmd_get_err(&xfer->cmds[0]);
> +
> +	return 0;
> +}
> +
> +static int adi_i3c_master_priv_xfers(struct i3c_dev_desc *dev,
> +				     struct i3c_priv_xfer *xfers,
> +				     int nxfers)
> +{
> +	struct i3c_master_controller *m = i3c_dev_get_master(dev);
> +	struct adi_i3c_master *master = to_adi_i3c_master(m);
> +	struct adi_i3c_xfer *xfer __free(kfree) = NULL;
> +	int i, ret;
> +
> +	if (!nxfers)
> +		return 0;
> +
> +	xfer = adi_i3c_master_alloc_xfer(master, nxfers);
> +	if (!xfer)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < nxfers; i++) {
> +		struct adi_i3c_cmd *ccmd = &xfer->cmds[i];
> +
> +		ccmd->cmd0 = REG_CMD_FIFO_0_DEV_ADDR(dev->info.dyn_addr);
> +
> +		if (xfers[i].rnw) {
> +			ccmd->cmd0 |= REG_CMD_FIFO_0_RNW;
> +			ccmd->rx_buf = xfers[i].data.in;
> +			ccmd->rx_len = xfers[i].len;
> +		} else {
> +			ccmd->tx_buf = xfers[i].data.out;
> +			ccmd->tx_len = xfers[i].len;
> +		}
> +
> +		ccmd->cmd0 |= REG_CMD_FIFO_0_LEN(xfers[i].len);
> +
> +		if (i < nxfers - 1)
> +			ccmd->cmd0 |= REG_CMD_FIFO_0_SR;
> +
> +		if (!i)
> +			ccmd->cmd0 |= REG_CMD_FIFO_0_BCAST;
> +	}
> +
> +	adi_i3c_master_queue_xfer(master, xfer);
> +	if (!wait_for_completion_timeout(&xfer->comp,
> +					 msecs_to_jiffies(1000)))
> +		adi_i3c_master_unqueue_xfer(master, xfer);
> +
> +	ret = xfer->ret;
> +
> +	for (i = 0; i < nxfers; i++)
> +		xfers[i].err = adi_i3c_cmd_get_err(&xfer->cmds[i]);
> +
> +	return ret;
> +}
> +
> +struct adi_i3c_i2c_dev_data {
> +	struct i3c_generic_ibi_pool *ibi_pool;
> +	u16 id;
> +	s16 ibi;
> +};
> +
> +static int adi_i3c_master_get_rr_slot(struct adi_i3c_master *master,
> +				      u8 dyn_addr)
> +{
> +	if (!master->free_rr_slots)
> +		return -ENOSPC;
> +
> +	return ffs(master->free_rr_slots) - 1;
> +}
> +
> +static int adi_i3c_master_reattach_i3c_dev(struct i3c_dev_desc *dev, u8 dyn_addr)
> +{
> +	struct i3c_master_controller *m = i3c_dev_get_master(dev);
> +	struct adi_i3c_master *master = to_adi_i3c_master(m);
> +	u8 addr;
> +
> +	addr = dev->info.dyn_addr ? dev->info.dyn_addr : dev->info.static_addr;
> +
> +	writel(REG_DEV_CHAR_ADDR(dyn_addr), master->regs + REG_DEV_CHAR);
> +	writel((readl(master->regs + REG_DEV_CHAR) &
> +		~REG_DEV_CHAR_IS_ATTACHED) | REG_DEV_CHAR_WEN,
> +	       master->regs + REG_DEV_CHAR);
> +
> +	writel(REG_DEV_CHAR_ADDR(addr), master->regs + REG_DEV_CHAR);
> +	writel(readl(master->regs + REG_DEV_CHAR) |
> +	       REG_DEV_CHAR_IS_ATTACHED | REG_DEV_CHAR_WEN,
> +	       master->regs + REG_DEV_CHAR);
> +
> +	return 0;
> +}
> +
> +static int adi_i3c_master_attach_i3c_dev(struct i3c_dev_desc *dev)
> +{
> +	struct i3c_master_controller *m = i3c_dev_get_master(dev);
> +	struct adi_i3c_master *master = to_adi_i3c_master(m);
> +	struct adi_i3c_i2c_dev_data *data;
> +	int slot;
> +	u8 addr;
> +
> +	data = kzalloc(sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	slot = adi_i3c_master_get_rr_slot(master, dev->info.dyn_addr);
> +	if (slot < 0) {
> +		kfree(data);
> +		return slot;
> +	}
> +
> +	data->id = slot;
> +	i3c_dev_set_master_data(dev, data);
> +	master->free_rr_slots &= ~BIT(slot);
> +
> +	addr = dev->info.dyn_addr ? dev->info.dyn_addr : dev->info.static_addr;
> +
> +	writel(REG_DEV_CHAR_ADDR(addr), master->regs + REG_DEV_CHAR);
> +	writel(readl(master->regs + REG_DEV_CHAR) |
> +	       REG_DEV_CHAR_IS_ATTACHED | REG_DEV_CHAR_WEN,
> +	       master->regs + REG_DEV_CHAR);
> +
> +	return 0;
> +}
> +
> +static void adi_i3c_master_sync_dev_char(struct i3c_master_controller *m)
> +{
> +	struct adi_i3c_master *master = to_adi_i3c_master(m);
> +	struct i3c_dev_desc *i3cdev;
> +	u32 bcr_ibi;
> +	u8 addr;
> +
> +	i3c_bus_for_each_i3cdev(&m->bus, i3cdev) {
> +		addr = i3cdev->info.dyn_addr ?
> +		       i3cdev->info.dyn_addr : i3cdev->info.static_addr;
> +		writel(REG_DEV_CHAR_ADDR(addr), master->regs + REG_DEV_CHAR);
> +		bcr_ibi = FIELD_GET(I3C_BCR_IBI_PAYLOAD | I3C_BCR_IBI_REQ_CAP, (i3cdev->info.bcr));
> +		writel(readl(master->regs + REG_DEV_CHAR) |
> +		       REG_DEV_CHAR_BCR_IBI(bcr_ibi) | REG_DEV_CHAR_WEN,
> +		       master->regs + REG_DEV_CHAR);
> +	}
> +}
> +
> +static void adi_i3c_master_detach_i3c_dev(struct i3c_dev_desc *dev)
> +{
> +	struct i3c_master_controller *m = i3c_dev_get_master(dev);
> +	struct adi_i3c_master *master = to_adi_i3c_master(m);
> +	struct adi_i3c_i2c_dev_data *data = i3c_dev_get_master_data(dev);
> +	u8 addr;
> +
> +	addr = dev->info.dyn_addr ? dev->info.dyn_addr : dev->info.static_addr;
> +
> +	writel(REG_DEV_CHAR_ADDR(addr), master->regs + REG_DEV_CHAR);
> +	writel((readl(master->regs + REG_DEV_CHAR) &
> +		~REG_DEV_CHAR_IS_ATTACHED) | REG_DEV_CHAR_WEN,
> +	       master->regs + REG_DEV_CHAR);
> +
> +	i3c_dev_set_master_data(dev, NULL);
> +	master->free_rr_slots |= BIT(data->id);
> +	kfree(data);
> +}
> +
> +static int adi_i3c_master_attach_i2c_dev(struct i2c_dev_desc *dev)
> +{
> +	struct i3c_master_controller *m = i2c_dev_get_master(dev);
> +	struct adi_i3c_master *master = to_adi_i3c_master(m);
> +	struct adi_i3c_i2c_dev_data *data;
> +	int slot;
> +
> +	slot = adi_i3c_master_get_rr_slot(master, 0);
> +	if (slot < 0)
> +		return slot;
> +
> +	data = kzalloc(sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	data->id = slot;
> +	master->free_rr_slots &= ~BIT(slot);
> +	i2c_dev_set_master_data(dev, data);
> +
> +	writel(REG_DEV_CHAR_ADDR(dev->addr) |
> +	       REG_DEV_CHAR_IS_I2C | REG_DEV_CHAR_IS_ATTACHED | REG_DEV_CHAR_WEN,
> +	       master->regs + REG_DEV_CHAR);
> +
> +	return 0;
> +}
> +
> +static void adi_i3c_master_detach_i2c_dev(struct i2c_dev_desc *dev)
> +{
> +	struct i3c_master_controller *m = i2c_dev_get_master(dev);
> +	struct adi_i3c_master *master = to_adi_i3c_master(m);
> +	struct adi_i3c_i2c_dev_data *data = i2c_dev_get_master_data(dev);
> +
> +	writel(REG_DEV_CHAR_ADDR(dev->addr) |
> +	       REG_DEV_CHAR_IS_I2C | REG_DEV_CHAR_WEN,
> +	       master->regs + REG_DEV_CHAR);
> +
> +	i2c_dev_set_master_data(dev, NULL);
> +	master->free_rr_slots |= BIT(data->id);
> +	kfree(data);
> +}
> +
> +static void adi_i3c_master_bus_cleanup(struct i3c_master_controller *m)
> +{
> +	struct adi_i3c_master *master = to_adi_i3c_master(m);
> +
> +	adi_i3c_master_disable(master);
> +}
> +
> +static void adi_i3c_master_upd_i3c_scl_lim(struct adi_i3c_master *master)
> +{
> +	struct i3c_master_controller *m = &master->base;
> +	struct i3c_bus *bus = i3c_master_get_bus(m);
> +	u8 i3c_scl_lim = 0;
> +	struct i3c_dev_desc *dev;
> +	u8 pp_sg;
> +
> +	i3c_bus_for_each_i3cdev(bus, dev) {
> +		u8 max_fscl;
> +
> +		max_fscl = max(I3C_CCC_MAX_SDR_FSCL(dev->info.max_read_ds),
> +			       I3C_CCC_MAX_SDR_FSCL(dev->info.max_write_ds));
> +
> +		switch (max_fscl) {
> +		case I3C_SDR1_FSCL_8MHZ:
> +			max_fscl = PP_SG_6MHZ;
> +			break;
> +		case I3C_SDR2_FSCL_6MHZ:
> +			max_fscl = PP_SG_3MHZ;
> +			break;
> +		case I3C_SDR3_FSCL_4MHZ:
> +			max_fscl = PP_SG_3MHZ;
> +			break;
> +		case I3C_SDR4_FSCL_2MHZ:
> +			max_fscl = PP_SG_1MHZ;
> +			break;
> +		case I3C_SDR0_FSCL_MAX:
> +		default:
> +			max_fscl = PP_SG_12MHZ;
> +			break;
> +		}
> +
> +		if (max_fscl &&
> +		    (i3c_scl_lim > max_fscl || !i3c_scl_lim))
> +			i3c_scl_lim = max_fscl;
> +	}
> +
> +	if (!i3c_scl_lim)
> +		return;
> +
> +	master->i3c_scl_lim = i3c_scl_lim - 1;
> +
> +	pp_sg = readl(master->regs + REG_OPS) & ~REG_OPS_PP_SG_MASK;
> +	pp_sg |= REG_OPS_SET_SG(master->i3c_scl_lim);
> +
> +	writel(pp_sg, master->regs + REG_OPS);
> +}
> +
> +static void adi_i3c_master_get_features(struct adi_i3c_master *master,
> +					unsigned int slot,
> +					struct i3c_device_info *info)
> +{
> +	u32 buf;
> +
> +	/* Dynamic address and PID are for identification only */
> +	memset(info, 0, sizeof(*info));
> +	buf = readl(master->regs + REG_DCR_BCR_DA);
> +	info->dyn_addr = REG_DCR_BCR_DA_GET_DA(buf);
> +	info->dcr = REG_DCR_BCR_DA_GET_DCR(buf);
> +	info->bcr = REG_DCR_BCR_DA_GET_BCR(buf);
> +	info->pid = readl(master->regs + REG_PID_L);
> +	info->pid |= (u64)readl(master->regs + REG_PID_H) << 32;
> +}
> +
> +static int adi_i3c_master_do_daa(struct i3c_master_controller *m)
> +{
> +	struct adi_i3c_master *master = to_adi_i3c_master(m);
> +	int ret, addr = 0;
> +	u32 irq_mask;
> +
> +	for (u8 i = 0; i < ADI_MAX_DEVS; i++) {
> +		addr = i3c_master_get_free_addr(m, addr);
> +		if (addr < 0)
> +			return addr;
> +		master->daa.addrs[i] = addr;
> +	}
> +
> +	irq_mask = readl(master->regs + REG_IRQ_MASK);
> +	writel(irq_mask | REG_IRQ_PENDING_DAA,
> +	       master->regs + REG_IRQ_MASK);
> +
> +	master->daa.index = 0;
> +	ret = i3c_master_entdaa_locked(&master->base);
> +
> +	writel(irq_mask, master->regs + REG_IRQ_MASK);
> +
> +	/* DAA always finishes with CE2_ERROR or NACK_RESP */
> +	if (ret && ret != I3C_ERROR_M2)
> +		return ret;
> +
> +	/* Add I3C devices discovered */
> +	for (u8 i = 0; i < master->daa.index; i++)
> +		i3c_master_add_i3c_dev_locked(m, master->daa.addrs[i]);
> +	/* Sync retrieved devs info with the IP */
> +	adi_i3c_master_sync_dev_char(m);
> +
> +	i3c_master_defslvs_locked(&master->base);
> +
> +	adi_i3c_master_upd_i3c_scl_lim(master);
> +
> +	return 0;
> +}
> +
> +static int adi_i3c_master_bus_init(struct i3c_master_controller *m)
> +{
> +	struct adi_i3c_master *master = to_adi_i3c_master(m);
> +	struct i3c_device_info info = { };
> +	int ret;
> +
> +	ret = i3c_master_get_free_addr(m, 0);
> +	if (ret < 0)
> +		return ret;
> +
> +	adi_i3c_master_get_features(master, 0, &info);
> +	ret = i3c_master_set_info(&master->base, &info);
> +	if (ret)
> +		return ret;
> +
> +	writel(REG_IBI_CONFIG_LISTEN,
> +	       master->regs + REG_IBI_CONFIG);
> +
> +	return 0;
> +}
> +
> +static void adi_i3c_master_handle_ibi(struct adi_i3c_master *master,
> +				      u32 raw)
> +{
> +	struct adi_i3c_i2c_dev_data *data;
> +	struct i3c_ibi_slot *slot;
> +	struct i3c_dev_desc *dev;
> +	u8 da, id, mdb, len;
> +	u8 *buf;
> +
> +	da = FIELD_GET(GENMASK(23, 17), raw);
> +	mdb = FIELD_GET(GENMASK(15, 8), raw);
> +	for (id = 0; id < master->ibi.num_slots; id++) {
> +		if (master->ibi.slots[id] &&
> +		    master->ibi.slots[id]->info.dyn_addr == da)
> +			break;
> +	}
> +
> +	if (id == master->ibi.num_slots)
> +		return;
> +
> +	dev = master->ibi.slots[id];
> +	len = ADI_HAS_MDB_FROM_BCR(dev->info.bcr);
> +	data = i3c_dev_get_master_data(dev);
> +
> +	guard(spinlock)(&master->ibi.lock);
> +	slot = i3c_generic_ibi_get_free_slot(data->ibi_pool);
> +	if (!slot)
> +		return;
> +
> +	slot->len = len;
> +	buf = slot->data;
> +	buf[0] = mdb;
> +	i3c_master_queue_ibi(dev, slot);
> +}
> +
> +static void adi_i3c_master_demux_ibis(struct adi_i3c_master *master)
> +{
> +	while (!(readl(master->regs + REG_FIFO_STATUS) & REG_FIFO_STATUS_IBI_EMPTY)) {
> +		u32 raw = readl(master->regs + REG_IBI_FIFO);
> +
> +		adi_i3c_master_handle_ibi(master, raw);
> +	}
> +}
> +
> +static void adi_i3c_master_handle_da_req(struct adi_i3c_master *master)
> +{
> +	u8 payload0[8];
> +	u32 addr;
> +
> +	adi_i3c_master_rd_from_rx_fifo(master, payload0, 6);
> +	addr = master->daa.addrs[master->daa.index++];
> +	addr = (addr << 1) | (parity8(addr) ? 0 : 1);
> +
> +	writel(addr, master->regs + REG_SDO_FIFO);
> +}
> +
> +static irqreturn_t adi_i3c_master_irq(int irq, void *data)
> +{
> +	struct adi_i3c_master *master = data;
> +	u32 pending;
> +
> +	pending = readl(master->regs + REG_IRQ_PENDING);
> +	writel(pending, master->regs + REG_IRQ_PENDING);
> +	if (pending & REG_IRQ_PENDING_CMDR) {
> +		scoped_guard(spinlock_irqsave, &master->xferqueue.lock) {
> +			adi_i3c_master_end_xfer_locked(master, pending);
> +		}
> +	}
> +	if (pending & REG_IRQ_PENDING_IBI)
> +		adi_i3c_master_demux_ibis(master);
> +	if (pending & REG_IRQ_PENDING_DAA)
> +		adi_i3c_master_handle_da_req(master);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int adi_i3c_master_i2c_xfers(struct i2c_dev_desc *dev,
> +				    struct i2c_msg *xfers,
> +				    int nxfers)
> +{
> +	struct i3c_master_controller *m = i2c_dev_get_master(dev);
> +	struct adi_i3c_master *master = to_adi_i3c_master(m);
> +	struct adi_i3c_xfer *xfer __free(kfree) = NULL;
> +	int i;
> +
> +	if (!nxfers)
> +		return 0;
> +	for (i = 0; i < nxfers; i++) {
> +		if (xfers[i].flags & I2C_M_TEN)
> +			return -EOPNOTSUPP;
> +	}
> +	xfer = adi_i3c_master_alloc_xfer(master, nxfers);
> +	if (!xfer)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < nxfers; i++) {
> +		struct adi_i3c_cmd *ccmd = &xfer->cmds[i];
> +
> +		ccmd->cmd0 = REG_CMD_FIFO_0_DEV_ADDR(xfers[i].addr);
> +
> +		if (xfers[i].flags & I2C_M_RD) {
> +			ccmd->cmd0 |= REG_CMD_FIFO_0_RNW;
> +			ccmd->rx_buf = xfers[i].buf;
> +			ccmd->rx_len = xfers[i].len;
> +		} else {
> +			ccmd->tx_buf = xfers[i].buf;
> +			ccmd->tx_len = xfers[i].len;
> +		}
> +
> +		ccmd->cmd0 |= REG_CMD_FIFO_0_LEN(xfers[i].len);
> +	}
> +
> +	adi_i3c_master_queue_xfer(master, xfer);
> +	if (!wait_for_completion_timeout(&xfer->comp,
> +					 m->i2c.timeout))
> +		adi_i3c_master_unqueue_xfer(master, xfer);
> +
> +	return xfer->ret;
> +}
> +
> +static int adi_i3c_master_disable_ibi(struct i3c_dev_desc *dev)
> +{
> +	struct i3c_master_controller *m = i3c_dev_get_master(dev);
> +	struct adi_i3c_master *master = to_adi_i3c_master(m);
> +	struct i3c_dev_desc *i3cdev;
> +	u32 enabled = 0;
> +	int ret;
> +
> +	ret = i3c_master_disec_locked(m, dev->info.dyn_addr,
> +				      I3C_CCC_EVENT_SIR);
> +
> +	i3c_bus_for_each_i3cdev(&m->bus, i3cdev) {
> +		if (dev != i3cdev && i3cdev->ibi)
> +			enabled |= i3cdev->ibi->enabled;
> +	}
> +	if (!enabled) {
> +		writel(REG_IBI_CONFIG_LISTEN,
> +		       master->regs + REG_IBI_CONFIG);
> +		writel(readl(master->regs + REG_IRQ_MASK) & ~REG_IRQ_PENDING_IBI,
> +		       master->regs + REG_IRQ_MASK);
> +	}
> +
> +	return ret;
> +}
> +
> +static int adi_i3c_master_enable_ibi(struct i3c_dev_desc *dev)
> +{
> +	struct i3c_master_controller *m = i3c_dev_get_master(dev);
> +	struct adi_i3c_master *master = to_adi_i3c_master(m);
> +
> +	writel(REG_IBI_CONFIG_LISTEN | REG_IBI_CONFIG_ENABLE,
> +	       master->regs + REG_IBI_CONFIG);
> +
> +	writel(readl(master->regs + REG_IRQ_MASK) | REG_IRQ_PENDING_IBI,
> +	       master->regs + REG_IRQ_MASK);
> +
> +	return i3c_master_enec_locked(m, dev->info.dyn_addr,
> +				      I3C_CCC_EVENT_SIR);
> +}
> +
> +static int adi_i3c_master_request_ibi(struct i3c_dev_desc *dev,
> +				      const struct i3c_ibi_setup *req)
> +{
> +	struct i3c_master_controller *m = i3c_dev_get_master(dev);
> +	struct adi_i3c_master *master = to_adi_i3c_master(m);
> +	struct adi_i3c_i2c_dev_data *data;
> +	unsigned int i;
> +
> +	data = i3c_dev_get_master_data(dev);
> +	data->ibi_pool = i3c_generic_ibi_alloc_pool(dev, req);
> +	if (IS_ERR(data->ibi_pool))
> +		return PTR_ERR(data->ibi_pool);
> +
> +	scoped_guard(spinlock_irqsave, &master->ibi.lock) {
> +		for (i = 0; i < master->ibi.num_slots; i++) {
> +			if (!master->ibi.slots[i]) {
> +				data->ibi = i;
> +				master->ibi.slots[i] = dev;
> +				break;
> +			}
> +		}
> +	}
> +
> +	if (i < master->ibi.num_slots)
> +		return 0;
> +
> +	i3c_generic_ibi_free_pool(data->ibi_pool);
> +	data->ibi_pool = NULL;
> +
> +	return -ENOSPC;
> +}
> +
> +static void adi_i3c_master_free_ibi(struct i3c_dev_desc *dev)
> +{
> +	struct i3c_master_controller *m = i3c_dev_get_master(dev);
> +	struct adi_i3c_master *master = to_adi_i3c_master(m);
> +	struct adi_i3c_i2c_dev_data *data = i3c_dev_get_master_data(dev);
> +
> +	scoped_guard(spinlock_irqsave, &master->ibi.lock) {
> +		master->ibi.slots[data->ibi] = NULL;
> +	}
> +
> +	i3c_generic_ibi_free_pool(data->ibi_pool);
> +}
> +
> +static void adi_i3c_master_recycle_ibi_slot(struct i3c_dev_desc *dev,
> +					    struct i3c_ibi_slot *slot)
> +{
> +	struct adi_i3c_i2c_dev_data *data = i3c_dev_get_master_data(dev);
> +
> +	i3c_generic_ibi_recycle_slot(data->ibi_pool, slot);
> +}
> +
> +static const struct i3c_master_controller_ops adi_i3c_master_ops = {
> +	.bus_init = adi_i3c_master_bus_init,
> +	.bus_cleanup = adi_i3c_master_bus_cleanup,
> +	.attach_i3c_dev = adi_i3c_master_attach_i3c_dev,
> +	.reattach_i3c_dev = adi_i3c_master_reattach_i3c_dev,
> +	.detach_i3c_dev = adi_i3c_master_detach_i3c_dev,
> +	.attach_i2c_dev = adi_i3c_master_attach_i2c_dev,
> +	.detach_i2c_dev = adi_i3c_master_detach_i2c_dev,
> +	.do_daa = adi_i3c_master_do_daa,
> +	.supports_ccc_cmd = adi_i3c_master_supports_ccc_cmd,
> +	.send_ccc_cmd = adi_i3c_master_send_ccc_cmd,
> +	.priv_xfers = adi_i3c_master_priv_xfers,
> +	.i2c_xfers = adi_i3c_master_i2c_xfers,
> +	.request_ibi = adi_i3c_master_request_ibi,
> +	.enable_ibi = adi_i3c_master_enable_ibi,
> +	.disable_ibi = adi_i3c_master_disable_ibi,
> +	.free_ibi = adi_i3c_master_free_ibi,
> +	.recycle_ibi_slot = adi_i3c_master_recycle_ibi_slot,
> +};
> +
> +static const struct of_device_id adi_i3c_master_of_match[] = {
> +	{ .compatible = "adi,i3c-master-v1" },
> +	{}
> +};
> +
> +static int adi_i3c_master_probe(struct platform_device *pdev)
> +{
> +	struct adi_i3c_master *master;
> +	struct clk_bulk_data *clk;
> +	unsigned int version;
> +	int ret, irq;
> +
> +	master = devm_kzalloc(&pdev->dev, sizeof(*master), GFP_KERNEL);
> +	if (!master)
> +		return -ENOMEM;
> +
> +	master->regs = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(master->regs))
> +		return PTR_ERR(master->regs);
> +
> +	ret = devm_clk_bulk_get_all_enabled(&pdev->dev, &clk);
> +	if (ret < 0)
> +		return dev_err_probe(&pdev->dev, ret,
> +				     "Failed to get clocks\n");
> +
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0)
> +		return irq;
> +
> +	version = readl(master->regs + ADI_AXI_REG_VERSION);
> +	if (ADI_AXI_PCORE_VER_MAJOR(version) != 1)
> +		dev_err_probe(&pdev->dev, -ENODEV, "Unsupported peripheral version %u.%u.%u\n",
> +			      ADI_AXI_PCORE_VER_MAJOR(version),
> +			      ADI_AXI_PCORE_VER_MINOR(version),
> +			      ADI_AXI_PCORE_VER_PATCH(version));
> +
> +	writel(0x00, master->regs + REG_ENABLE);
> +	writel(0x00, master->regs + REG_IRQ_MASK);
> +
> +	ret = devm_request_irq(&pdev->dev, irq, adi_i3c_master_irq, 0,
> +			       dev_name(&pdev->dev), master);
> +	if (ret)
> +		return ret;
> +
> +	platform_set_drvdata(pdev, master);
> +
> +	master->free_rr_slots = GENMASK(ADI_MAX_DEVS, 1);
> +
> +	writel(REG_IRQ_PENDING_CMDR, master->regs + REG_IRQ_MASK);
> +
> +	spin_lock_init(&master->ibi.lock);
> +	master->ibi.num_slots = 15;
> +	master->ibi.slots = devm_kcalloc(&pdev->dev, master->ibi.num_slots,
> +					 sizeof(*master->ibi.slots),
> +					 GFP_KERNEL);
> +	if (!master->ibi.slots)
> +		return -ENOMEM;
> +
> +	spin_lock_init(&master->xferqueue.lock);
> +	INIT_LIST_HEAD(&master->xferqueue.list);
> +
> +	return i3c_master_register(&master->base, &pdev->dev,
> +				   &adi_i3c_master_ops, false);
> +}
> +
> +static void adi_i3c_master_remove(struct platform_device *pdev)
> +{
> +	struct adi_i3c_master *master = platform_get_drvdata(pdev);
> +
> +	writel(0xff, master->regs + REG_IRQ_PENDING);
> +	writel(0x00, master->regs + REG_IRQ_MASK);
> +	writel(0x01, master->regs + REG_ENABLE);
> +
> +	i3c_master_unregister(&master->base);
> +}
> +
> +static struct platform_driver adi_i3c_master = {
> +	.probe = adi_i3c_master_probe,
> +	.remove = adi_i3c_master_remove,
> +	.driver = {
> +		.name = "adi-i3c-master",
> +		.of_match_table = adi_i3c_master_of_match,
> +	},
> +};
> +module_platform_driver(adi_i3c_master);
> +
> +MODULE_AUTHOR("Jorge Marques <jorge.marques@analog.com>");
> +MODULE_DESCRIPTION("Analog Devices I3C master driver");
> +MODULE_LICENSE("GPL");
>
> --
> 2.49.0
>
